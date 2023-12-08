output "vpc_arn" {
  value       = module.vpc.vpc_arn
  description = "Amazon Resource Name (ARN) of VPC."
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC."
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "The CIDR block of the VPC."
}

output "vpc_enable_dns_support" {
  value       = module.vpc.default_vpc_enable_dns_support
  description = "Whether or not the VPC has DNS support."
}

output "vpc_enable_dns_hostnames" {
  value       = module.vpc.default_vpc_enable_dns_hostnames
  description = "Whether or not the VPC has DNS hostname support."
}

output "vpc_main_route_table_id" {
  value       = module.vpc.default_vpc_main_route_table_id
  description = "The ID of the main route table associated with this VPC."
}

output "vpc_default_network_acl_id" {
  value       = module.vpc.default_network_acl_id
  description = "The ID of the network ACL created by default on VPC creation."
}

output "vpc_default_security_group_id" {
  value       = module.vpc.default_security_group_id
  description = "The ID of the security group created by default on VPC creation."
}

output "vpc_default_route_table_id" {
  value       = module.vpc.default_route_table_id
  description = "The ID of the route table created by default on VPC creation."
}

output "internet_gateway_id" {
  value       = module.vpc.public_internet_gateway_route_id
  description = "The ID of the Internet Gateway."
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "The ID of the Internet Gateway."
}

output "intra_subnets" {
  value       = module.vpc.intra_subnets
  description = "The ID of the Internet Gateway."
}