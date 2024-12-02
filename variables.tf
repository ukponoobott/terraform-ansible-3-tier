variable "subscription_id" {
  description = "The subscription ID for the Azure account where the resources will be provisioned. This value is used to authenticate Terraform to the correct Azure subscription."
  type        = string
}

variable "cloudflare_api_token" {
  description = "The API token used to authenticate with the Cloudflare API. This token grants Terraform the required permissions to manage DNS records, zones, or other Cloudflare resources."
  type        = string
}

variable "workload" {
  description = "The workload or purpose of the resources, e.g., 'docker', 'webapp'."
  type        = string
}

variable "environment" {
  description = "The environment for the resources, e.g., 'dev', 'prod', 'staging'."
  type        = string
}

variable "location" {
  description = "The Azure Region where the resources should exist. Changing this forces new resources to be created."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space."
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet. Changing this forces a new subnet to be created."
  type        = string
}

variable "web_subnet_address_prefix" {
  description = "The address prefixes for the subnet."
  type        = list(string)
}

variable "public_ip_sku" {
  description = "The SKU of the Public IP. Accepted values are `Basic` and `Standard`."
  type        = string
  default     = "Basic"
}

variable "public_ip_allocation_method" {
  description = "Defines the allocation method for the Public IP address. Possible values are `Static` or `Dynamic`."
  type        = string
  default     = "Dynamic"
}

variable "vm_size" {
  description = "The size of the Virtual Machine, such as `Standard_B2s`."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "The Admin Username for the Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "ssh_private_key" {
  description = "The private key for SSH authentication, used for connecting to provisioned Azure virtual machines. This should match the public key associated with the VM."
  type        = string
}

variable "ssh_public_key" {
  description = "The public key for SSH authentication, used to allow secure access to provisioned Azure virtual machines. This key is paired with a private key (ssh_private_key) and is added to the VM during provisioning."
  type        = string
}

variable "ansible_inventory_file" {
  description = "The path to the file where the Ansible inventory will be stored."
  type        = string
  default     = "./inventory.ini"
}

variable "cloudflare_zone_name" {
  description = "The name of the DNS zone in Cloudflare."
  type        = string
}

variable "cloudflare_record_name" {
  description = "The name of the DNS record to create in the Cloudflare zone."
  type        = string
}

variable "cloudflare_record_ttl" {
  description = "The TTL of the DNS record. Minimum value is 1."
  type        = number
  default     = 3600
}