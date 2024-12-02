## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.11.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.44.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.11.0 |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 4.44.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.3 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/virtual_network) | resource |
| [cloudflare_record.this](https://registry.terraform.io/providers/cloudflare/cloudflare/4.44.0/docs/resources/record) | resource |
| [local_file.ansible_inventory](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.ansible](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait_2_minutes](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [cloudflare_zone.this](https://registry.terraform.io/providers/cloudflare/cloudflare/4.44.0/docs/data-sources/zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The Admin Username for the Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_ansible_inventory_file"></a> [ansible\_inventory\_file](#input\_ansible\_inventory\_file) | The path to the file where the Ansible inventory will be stored. | `string` | `"./inventory.ini"` | no |
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | The API token used to authenticate with the Cloudflare API. This token grants Terraform the required permissions to manage DNS records, zones, or other Cloudflare resources. | `string` | n/a | yes |
| <a name="input_cloudflare_record_name"></a> [cloudflare\_record\_name](#input\_cloudflare\_record\_name) | The name of the DNS record to create in the Cloudflare zone. | `string` | n/a | yes |
| <a name="input_cloudflare_record_ttl"></a> [cloudflare\_record\_ttl](#input\_cloudflare\_record\_ttl) | The TTL of the DNS record. Minimum value is 1. | `number` | `3600` | no |
| <a name="input_cloudflare_zone_name"></a> [cloudflare\_zone\_name](#input\_cloudflare\_zone\_name) | The name of the DNS zone in Cloudflare. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the resources, e.g., 'dev', 'prod', 'staging'. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the resources should exist. Changing this forces new resources to be created. | `string` | n/a | yes |
| <a name="input_public_ip_allocation_method"></a> [public\_ip\_allocation\_method](#input\_public\_ip\_allocation\_method) | Defines the allocation method for the Public IP address. Possible values are `Static` or `Dynamic`. | `string` | `"Dynamic"` | no |
| <a name="input_public_ip_sku"></a> [public\_ip\_sku](#input\_public\_ip\_sku) | The SKU of the Public IP. Accepted values are `Basic` and `Standard`. | `string` | `"Basic"` | no |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | The private key for SSH authentication, used for connecting to provisioned Azure virtual machines. This should match the public key associated with the VM. | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The public key for SSH authentication, used to allow secure access to provisioned Azure virtual machines. This key is paired with a private key (ssh\_private\_key) and is added to the VM during provisioning. | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet. Changing this forces a new subnet to be created. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The subscription ID for the Azure account where the resources will be provisioned. This value is used to authenticate Terraform to the correct Azure subscription. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The size of the Virtual Machine, such as `Standard_B2s`. | `string` | `"Standard_B2s"` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The address space that is used by the virtual network. You can supply more than one address space. | `list(string)` | n/a | yes |
| <a name="input_web_subnet_address_prefix"></a> [web\_subnet\_address\_prefix](#input\_web\_subnet\_address\_prefix) | The address prefixes for the subnet. | `list(string)` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload or purpose of the resources, e.g., 'docker', 'webapp'. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_public_ip"></a> [vm\_public\_ip](#output\_vm\_public\_ip) | n/a |

# Run Process

## Prerequisites

### Before starting, ensure the following tools are installed:
	•	Terraform: Install from Terraform Downloads.
	•	Ansible: Install via pip:
  ```bash
  pip install ansible
  ```

### Clone the Repository
Clone the project repository to your local machine

```bash
git clone <repository-url>
cd <repository-directory>
```

### Set Up Terraform
Install required Terraform providers and modules

```bash
terraform init
```

### Prepare Variables
Update the terraform.tfvars file with your specific values (e.g., subscription_id, ssh_public_key, cloudflare_api_token, etc.).

### Run Terraform
Plan the infrastructure changes

```bash
terraform plan
```

### Apply the configuration to provision the infrastructure
```bash
terraform apply
```

### Run Ansible
After Terraform provisions the infrastructure, Ansible playbooks will automatically handle system configuration and application deployments. Ensure that ansible is installed and accessible.