subscription_id      = ""
cloudflare_api_token = ""

workload                  = "docker"
environment               = "dev"
location                  = "eastus2"
vnet_address_space        = ["10.0.0.0/16"]
subnet_name               = "web"
web_subnet_address_prefix = ["10.0.0.0/24"]

vm_size         = "Standard_B2s"
admin_username  = "adminuser"
ssh_public_key  = "~/.ssh/id_rsa.pub"
ssh_private_key = "~/.ssh/id_rsa"

cloudflare_zone_name   = ""
cloudflare_record_name = "app"