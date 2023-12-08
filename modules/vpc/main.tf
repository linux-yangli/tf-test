# Terraform module which creates VPC resources on AWS.
#
# https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html

# https://www.terraform.io/docs/providers/aws/r/vpc.html
resource "aws_vpc" "default" {
  cidr_block = var.cidr_block

  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = { "Name" = var.name }
}

# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags   = { "Name" = var.name }
}

#
# Public network
#

# https://www.terraform.io/docs/providers/aws/r/subnet.html
resource "aws_subnet" "public" {
  for_each = var.public_subnet_cidr_blocks

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["az"]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    "Name" = format("%s-public-%s", each.value["name"], each.value["az"])
  }
}

# https://www.terraform.io/docs/providers/aws/r/route_table.html
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id
  tags = {
    "Name" = format("%s-public", var.name)
  }
}

# https://www.terraform.io/docs/providers/aws/r/route.html
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.default.id
  destination_cidr_block = "0.0.0.0/0"
}

# https://www.terraform.io/docs/providers/aws/r/route_table_association.html
resource "aws_route_table_association" "public" {
  depends_on = [aws_subnet.public]
  for_each   = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# https://www.terraform.io/docs/providers/aws/r/network_acl.html
resource "aws_network_acl" "public" {
  depends_on = [aws_subnet.public]

  for_each = aws_subnet.public

  vpc_id     = aws_vpc.default.id
  subnet_ids = toset([each.value.id])
  tags = {
    "Name" = format("%s-public", var.name)
  }
}

# https://www.terraform.io/docs/providers/aws/r/network_acl_rule.html
resource "aws_network_acl_rule" "public_ingress" {
  depends_on = [aws_network_acl.public]

  for_each = aws_network_acl.public

  network_acl_id = aws_network_acl.public[each.key].id
  egress         = false
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "public_egress" {
  for_each = aws_network_acl.public

  network_acl_id = aws_network_acl.public[each.key].id
  egress         = true
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}

#
# Private network
#

# https://www.terraform.io/docs/providers/aws/r/subnet.html
resource "aws_subnet" "private" {
  for_each = var.private_subnet_cidr_blocks

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["az"]
  map_public_ip_on_launch = false
  tags = {
    "Name" = format("%s-private-%s", each.value["name"], each.value["az"])
  }
}

# Note: Do not use network_interface to associate the EIP to aws_lb or aws_nat_gateway resources.
#       Instead use the allocation_id available in those resources to allow AWS to manage the association,
#       otherwise you will see AuthFailure errors.
#
# https://www.terraform.io/docs/providers/aws/r/eip.html
resource "aws_eip" "nat_gateway" {
  for_each = aws_subnet.public

  vpc = true
  tags = {
    "Name" = format("nat-%s", each.value["az"])
  }

  # Note: EIP may require IGW to exist prior to association. Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.default]
}

# https://www.terraform.io/docs/providers/aws/r/nat_gateway.html
resource "aws_nat_gateway" "default" {
  for_each = aws_subnet.public

  allocation_id = aws_eip.nat_gateway[each.key].id
  subnet_id     = each.value.id
  #tags          = merge({ "Name" = format("%s-nat-%s", each.value["az"]) })

  # Note: It's recommended to denote that the NAT Gateway depends on the Internet Gateway
  #       for the VPC in which the NAT Gateway's subnet is located.
  depends_on = [aws_internet_gateway.default]
}

# https://www.terraform.io/docs/providers/aws/r/route_table.html
resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.default.id
  tags   = { "Name" = format("%s-private", "icarus") }
}

locals {
  nat_gateways_by_subnet = { for nat in aws_nat_gateway.default : nat.id => nat.subnet_id }
  public_subnets_by_az   = { for subnet in aws_subnet.public : subnet.id => subnet.availability_zone }
  nat_gateways_by_az     = { for public_subnet, az in local.public_subnets_by_az : az => [for id, nat_subnet in local.nat_gateways_by_subnet : id if public_subnet == nat_subnet] }
  nat_gateway_ids        = sort(flatten(values(local.nat_gateways_by_az)))
}

# https://www.terraform.io/docs/providers/aws/r/route.html
resource "aws_route" "private" {
  for_each = aws_subnet.private

  route_table_id         = aws_route_table.private[each.key].id
  nat_gateway_id         = var.enabled_single_nat_gateway ? local.nat_gateway_ids[0] : local.nat_gateways_by_az[each.value.availability_zone][0]
  destination_cidr_block = "0.0.0.0/0"
}

# https://www.terraform.io/docs/providers/aws/r/route_table_association.html
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

# https://www.terraform.io/docs/providers/aws/r/network_acl.html
resource "aws_network_acl" "private" {
  depends_on = [aws_subnet.private]

  for_each = aws_subnet.private

  vpc_id     = aws_vpc.default.id
  subnet_ids = toset([each.value.id])
  tags       = { "Name" = format("%s-private", var.name) }
}

# https://www.terraform.io/docs/providers/aws/r/network_acl_rule.html
resource "aws_network_acl_rule" "private_ingress" {
  depends_on = [aws_network_acl.private]

  for_each = aws_network_acl.private

  network_acl_id = aws_network_acl.private[each.key].id
  egress         = false
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "private_egress" {
  depends_on = [aws_network_acl.private]
  for_each   = aws_network_acl.private

  network_acl_id = aws_network_acl.private[each.key].id
  egress         = true
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}

locals {
  nat_gateway_count = var.enabled_nat_gateway ? var.enabled_single_nat_gateway ? 1 : length(var.private_subnet_cidr_blocks) : 0
}
