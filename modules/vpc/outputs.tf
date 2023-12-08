output "vpc_arn" {
  value       = aws_vpc.default.arn
  description = "Amazon Resource Name (ARN) of VPC."
}

output "vpc_id" {
  value       = aws_vpc.default.id
  description = "The ID of the VPC."
}

output "vpc_cidr_block" {
  value       = aws_vpc.default.cidr_block
  description = "The CIDR block of the VPC."
}

output "vpc_instance_tenancy" {
  value       = aws_vpc.default.instance_tenancy
  description = "Tenancy of instances spin up within VPC."
}

output "vpc_enable_dns_support" {
  value       = aws_vpc.default.enable_dns_support
  description = "Whether or not the VPC has DNS support."
}

output "vpc_enable_dns_hostnames" {
  value       = aws_vpc.default.enable_dns_hostnames
  description = "Whether or not the VPC has DNS hostname support."
}

output "vpc_main_route_table_id" {
  value       = aws_vpc.default.main_route_table_id
  description = "The ID of the main route table associated with this VPC."
}

output "vpc_default_network_acl_id" {
  value       = aws_vpc.default.default_network_acl_id
  description = "The ID of the network ACL created by default on VPC creation."
}

output "vpc_default_security_group_id" {
  value       = aws_vpc.default.default_security_group_id
  description = "The ID of the security group created by default on VPC creation."
}

output "vpc_default_route_table_id" {
  value       = aws_vpc.default.default_route_table_id
  description = "The ID of the route table created by default on VPC creation."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.default.id
  description = "The ID of the Internet Gateway."
}

output "public_subnet_ids" {
  value = tomap({
    for k, v in aws_subnet.public :
    k => v.id
  })
  description = "The IDs of the public subnets."
}

output "public_subnet_arns" {
  value = tomap({
    for k, v in aws_subnet.public :
    k => v.arn
  })
  description = "The ARNs of the public subnets."
}

output "public_subnet_cidr_blocks" {
  value = tomap({
    for k, v in aws_subnet.public :
    k => v.cidr_block
  })
  description = "The CIDR blocks for the public subnets."
}

output "public_subnet_availability_zones" {
  value = tomap({
    for k, v in aws_subnet.public :
    k => v.availability_zone
  })
  description = "The Availability Zones for the public subnets."
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "The ID of the public routing table."
}

output "public_route_table_association_ids" {
  value = tomap({
    for k, b in aws_route_table_association.public :
    k => b.id
  })
  description = "The IDs of the public associations."
}

output "public_network_acl_id" {
  value = tomap({
    for k, n in aws_network_acl.public :
    k => n.id
  })
  description = "The ID of the public network ACL."
}

output "public_ingress_network_acl_rule_id" {
  value = tomap({
    for k, i in aws_network_acl_rule.public_ingress :
    k => i.id
  })
  description = "The ID of the public ingress network ACL Rule."
}

output "public_egress_network_acl_rule_id" {
  value = tomap({
    for k, i in aws_network_acl_rule.public_egress :
    k => i.id
  })
  description = "The ID of the public egress network ACL Rule."
}

output "private_subnet_ids" {
  value       = tomap({ for k, bd in aws_subnet.private : k => bd.id })
  description = "The IDs of the private subnets."
}

output "private_subnet_arns" {
  value = tomap({
    for k, bd in aws_subnet.private :
    k => bd.arn
  })
  description = "The ARNs of the private subnets."
}

output "private_subnet_cidr_blocks" {
  value = tomap({
    for k, b in aws_subnet.private :
    k => b.cidr_block
  })
  description = "The CIDR blocks for the private subnets."
}

output "private_subnet_availability_zones" {
  value = tomap({
    for k, v in aws_subnet.private :
    k => v.availability_zone
  })
  description = "The Availability Zones for the private subnets."
}

output "eip_nat_gateway_ids" {
  value = tomap({
    for k, i in aws_eip.nat_gateway :
    k => i.id
  })
  description = "Contains the EIP allocation IDs."
}

output "eip_nat_gateway_private_ips" {
  value = tomap({
    for k, v in aws_eip.nat_gateway :
    k => v.private_ip
  })
  description = "Contains the private IP addresses (if in VPC)."
}

output "eip_nat_gateway_public_ips" {
  value = tomap({
    for k, v in aws_eip.nat_gateway :
    k => v.public_ip
  })
  description = "Contains the public IP addresses."
}

output "nat_gateway_ids" {
  value = tomap({
    for k, v in aws_nat_gateway.default :
    k => v.id
  })
  description = "The IDs of the NAT Gateways."
}

output "nat_gateway_allocation_ids" {
  value = tomap({
    for k, v in aws_nat_gateway.default :
    k => v.allocation_id
  })
  description = "The Allocation IDs of the Elastic IP address for the gateways."
}

output "nat_gateway_subnet_ids" {
  value = tomap({
    for k, v in aws_nat_gateway.default :
    k => v.subnet_id
  })
  description = "The Subnet IDs of the subnet in which the NAT gateways are placed."
}

output "nat_gateway_network_interface_ids" {
  value = tomap({
    for k, v in aws_nat_gateway.default :
    k => v.network_interface_id
  })
  description = "The ENI IDs of the network interface created by the NAT gateways."
}

output "nat_gateway_private_ips" {
  value = tomap({
    for k, v in aws_nat_gateway.default :
    k => v.private_ip
  })
  description = "The private IP addresses of the NAT Gateways."
}

output "nat_gateway_public_ips" {
  value = tomap({
    for k, v in aws_nat_gateway.default :
    k => v.public_ip
  })
  description = "The public IP addresses of the NAT Gateways."
}

output "private_route_table_ids" {
  value = tomap({
    for k, v in aws_route_table.private :
    k => v.id
  })
  description = "The IDs of the private routing tables."
}

output "private_route_table_association_ids" {
  value = tomap({
    for k, v in aws_route_table_association.private :
    k => v.id
  })
  description = "The IDs of the private associations."
}

output "private_network_acl_id" {
  value = tomap({
    for k, i in aws_network_acl.private :
    k => i.id
  })
  description = "The ID of the private network ACL."
}

output "private_ingress_network_acl_rule_id" {
  value = tomap({
    for k, a in aws_network_acl_rule.private_ingress :
    k => a.id
  })
  description = "The ID of the private ingress network ACL Rule."
}

output "private_egress_network_acl_rule_id" {
  value = tomap({
    for k, i in aws_network_acl_rule.private_egress :
    k => i.id
  })
  description = "The ID of the private egress network ACL Rule."
}