resource "azurerm_resource_group" "this" {
  name     = "rg-${var.workload}-${var.environment}-${var.location}"
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.workload}-${var.environment}-${var.location}"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.web_subnet_address_prefix
}

resource "azurerm_public_ip" "this" {
  name                = "pip-${var.workload}-${var.environment}-${var.location}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = var.public_ip_sku
  allocation_method   = var.public_ip_allocation_method
}

resource "azurerm_network_interface" "this" {
  name                = "nic-${var.workload}-${var.environment}-${var.location}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = "vm-${var.workload}-${var.environment}-${var.location}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  depends_on = [azurerm_network_security_group.this]
}

locals {
  ansible_inventory = templatefile("${path.module}/ansible_inventory.tpl", {
    vm_name         = azurerm_linux_virtual_machine.this.name
    ip_address      = azurerm_public_ip.this.ip_address
    ansible_user    = var.admin_username
    ssh_private_key = var.ssh_private_key
  })
}

resource "local_file" "ansible_inventory" {
  filename = var.ansible_inventory_file
  content  = local.ansible_inventory
}

resource "azurerm_network_security_group" "this" {
  name                = "nsg-${var.workload}-${var.environment}-${var.location}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "Allow-All-Outbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*" // Use known IP
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS-IN"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-HTTPS-OUT"
    priority                   = 205
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "time_sleep" "wait_2_minutes" {
  create_duration = "120s"

  depends_on = [azurerm_linux_virtual_machine.this]
}

data "cloudflare_zone" "this" {
  name = var.cloudflare_zone_name
}

resource "cloudflare_record" "this" {
  zone_id = data.cloudflare_zone.this.id
  name    = var.cloudflare_record_name
  value   = azurerm_public_ip.this.ip_address
  type    = "A"
  proxied = false
  ttl     = 3600
}

resource "null_resource" "ansible" {
  depends_on = [
    azurerm_public_ip.this,
    azurerm_linux_virtual_machine.this,
    time_sleep.wait_2_minutes
  ]
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory.ini playbook.yaml"
  }
}