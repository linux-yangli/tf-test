## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_rule.private_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.private_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.public_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.public_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The CIDR block for the VPC. | `string` | n/a | yes |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | A boolean flag to enable/disable DNS hostnames in the VPC. | `string` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | A boolean flag to enable/disable DNS support in the VPC. | `string` | `true` | no |
| <a name="input_enabled_nat_gateway"></a> [enabled\_nat\_gateway](#input\_enabled\_nat\_gateway) | Set to false to prevent the module from creating NAT Gateway resources. | `string` | `true` | no |
| <a name="input_enabled_single_nat_gateway"></a> [enabled\_single\_nat\_gateway](#input\_enabled\_single\_nat\_gateway) | Set to true to create single NAT Gateway resource. | `string` | `false` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | A tenancy option for instances launched into the VPC. | `string` | `"default"` | no |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | Specify true to indicate that instances launched into the subnet should be assigned a public IP address. | `string` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name for the VPC. | `string` | n/a | yes |
| <a name="input_private_subnet_cidr_blocks"></a> [private\_subnet\_cidr\_blocks](#input\_private\_subnet\_cidr\_blocks) | The CIDR blocks for the private subnets. | <pre>map(object({<br>    name = string<br>    cidr = string<br>    az   = string<br>    tags = map(string)<br>  }))</pre> | n/a | yes |
| <a name="input_public_subnet_cidr_blocks"></a> [public\_subnet\_cidr\_blocks](#input\_public\_subnet\_cidr\_blocks) | The CIDR blocks for the public subnets. | <pre>map(object({<br>    name = string<br>    cidr = string<br>    az   = string<br>    tags = map(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eip_nat_gateway_ids"></a> [eip\_nat\_gateway\_ids](#output\_eip\_nat\_gateway\_ids) | Contains the EIP allocation IDs. |
| <a name="output_eip_nat_gateway_private_ips"></a> [eip\_nat\_gateway\_private\_ips](#output\_eip\_nat\_gateway\_private\_ips) | Contains the private IP addresses (if in VPC). |
| <a name="output_eip_nat_gateway_public_ips"></a> [eip\_nat\_gateway\_public\_ips](#output\_eip\_nat\_gateway\_public\_ips) | Contains the public IP addresses. |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | The ID of the Internet Gateway. |
| <a name="output_nat_gateway_allocation_ids"></a> [nat\_gateway\_allocation\_ids](#output\_nat\_gateway\_allocation\_ids) | The Allocation IDs of the Elastic IP address for the gateways. |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | The IDs of the NAT Gateways. |
| <a name="output_nat_gateway_network_interface_ids"></a> [nat\_gateway\_network\_interface\_ids](#output\_nat\_gateway\_network\_interface\_ids) | The ENI IDs of the network interface created by the NAT gateways. |
| <a name="output_nat_gateway_private_ips"></a> [nat\_gateway\_private\_ips](#output\_nat\_gateway\_private\_ips) | The private IP addresses of the NAT Gateways. |
| <a name="output_nat_gateway_public_ips"></a> [nat\_gateway\_public\_ips](#output\_nat\_gateway\_public\_ips) | The public IP addresses of the NAT Gateways. |
| <a name="output_nat_gateway_subnet_ids"></a> [nat\_gateway\_subnet\_ids](#output\_nat\_gateway\_subnet\_ids) | The Subnet IDs of the subnet in which the NAT gateways are placed. |
| <a name="output_private_egress_network_acl_rule_id"></a> [private\_egress\_network\_acl\_rule\_id](#output\_private\_egress\_network\_acl\_rule\_id) | The ID of the private egress network ACL Rule. |
| <a name="output_private_ingress_network_acl_rule_id"></a> [private\_ingress\_network\_acl\_rule\_id](#output\_private\_ingress\_network\_acl\_rule\_id) | The ID of the private ingress network ACL Rule. |
| <a name="output_private_network_acl_id"></a> [private\_network\_acl\_id](#output\_private\_network\_acl\_id) | The ID of the private network ACL. |
| <a name="output_private_route_table_association_ids"></a> [private\_route\_table\_association\_ids](#output\_private\_route\_table\_association\_ids) | The IDs of the private associations. |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | The IDs of the private routing tables. |
| <a name="output_private_subnet_arns"></a> [private\_subnet\_arns](#output\_private\_subnet\_arns) | The ARNs of the private subnets. |
| <a name="output_private_subnet_availability_zones"></a> [private\_subnet\_availability\_zones](#output\_private\_subnet\_availability\_zones) | The Availability Zones for the private subnets. |
| <a name="output_private_subnet_cidr_blocks"></a> [private\_subnet\_cidr\_blocks](#output\_private\_subnet\_cidr\_blocks) | The CIDR blocks for the private subnets. |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | The IDs of the private subnets. |
| <a name="output_public_egress_network_acl_rule_id"></a> [public\_egress\_network\_acl\_rule\_id](#output\_public\_egress\_network\_acl\_rule\_id) | The ID of the public egress network ACL Rule. |
| <a name="output_public_ingress_network_acl_rule_id"></a> [public\_ingress\_network\_acl\_rule\_id](#output\_public\_ingress\_network\_acl\_rule\_id) | The ID of the public ingress network ACL Rule. |
| <a name="output_public_network_acl_id"></a> [public\_network\_acl\_id](#output\_public\_network\_acl\_id) | The ID of the public network ACL. |
| <a name="output_public_route_table_association_ids"></a> [public\_route\_table\_association\_ids](#output\_public\_route\_table\_association\_ids) | The IDs of the public associations. |
| <a name="output_public_route_table_id"></a> [public\_route\_table\_id](#output\_public\_route\_table\_id) | The ID of the public routing table. |
| <a name="output_public_subnet_arns"></a> [public\_subnet\_arns](#output\_public\_subnet\_arns) | The ARNs of the public subnets. |
| <a name="output_public_subnet_availability_zones"></a> [public\_subnet\_availability\_zones](#output\_public\_subnet\_availability\_zones) | The Availability Zones for the public subnets. |
| <a name="output_public_subnet_cidr_blocks"></a> [public\_subnet\_cidr\_blocks](#output\_public\_subnet\_cidr\_blocks) | The CIDR blocks for the public subnets. |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | The IDs of the public subnets. |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | Amazon Resource Name (ARN) of VPC. |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC. |
| <a name="output_vpc_default_network_acl_id"></a> [vpc\_default\_network\_acl\_id](#output\_vpc\_default\_network\_acl\_id) | The ID of the network ACL created by default on VPC creation. |
| <a name="output_vpc_default_route_table_id"></a> [vpc\_default\_route\_table\_id](#output\_vpc\_default\_route\_table\_id) | The ID of the route table created by default on VPC creation. |
| <a name="output_vpc_default_security_group_id"></a> [vpc\_default\_security\_group\_id](#output\_vpc\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation. |
| <a name="output_vpc_enable_dns_hostnames"></a> [vpc\_enable\_dns\_hostnames](#output\_vpc\_enable\_dns\_hostnames) | Whether or not the VPC has DNS hostname support. |
| <a name="output_vpc_enable_dns_support"></a> [vpc\_enable\_dns\_support](#output\_vpc\_enable\_dns\_support) | Whether or not the VPC has DNS support. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC. |
| <a name="output_vpc_instance_tenancy"></a> [vpc\_instance\_tenancy](#output\_vpc\_instance\_tenancy) | Tenancy of instances spin up within VPC. |
| <a name="output_vpc_main_route_table_id"></a> [vpc\_main\_route\_table\_id](#output\_vpc\_main\_route\_table\_id) | The ID of the main route table associated with this VPC. |
