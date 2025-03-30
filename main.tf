resource "random_pet" "rg_name" {
  length = 2
}

resource "xkcdpass_generate" "postgres_pass" {
  length = 6
}

resource "xkcdpass_generate" "rm_db_pass" {
  length = 6
}

resource "xkcdpass_generate" "bl_db_pass" {
  length = 6
}

resource "xkcdpass_generate" "kc_db_pass" {
  length = 6
}

resource "xkcdpass_generate" "kc_admin_pass" {
  length = 6
}

resource "xkcdpass_generate" "kc_keystore_pass" {
  length = 6
}

resource "xkcdpass_generate" "kc_truststore_pass" {
  length = 6
}

resource "xkcdpass_generate" "kc_ldap_pass" {
  length = 6
}

resource "xkcdpass_generate" "tak_db_pass" {
  length = 6
}

resource "xkcdpass_generate" "tak_jks1_pass" {
  length = 6
}

resource "xkcdpass_generate" "tak_jks2_pass" {
  length = 6
}

locals {
  today           = timestamp()
  one_month_later = timeadd(local.today, "720h")
  expires         = var.EXPIRES != null ? var.EXPIRES : formatdate("YYYY-MM-DD", local.one_month_later)
  DEPLOYMENT_NAME = var.DEPLOYMENT_NAME != null ? var.DEPLOYMENT_NAME : random_pet.rg_name.id
}

resource "azurerm_resource_group" "this" {
  location = var.RESOURCE_GROUP_LOCATION
  name     = "${var.RESOURCE_GROUP_NAME_PREFIX}-${local.DEPLOYMENT_NAME}"
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
  }
}

resource "azurerm_virtual_network" "this" {
  name                = "${local.DEPLOYMENT_NAME}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

resource "azurerm_subnet" "this" {
  name                 = "${local.DEPLOYMENT_NAME}-snet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "this" {
  name                = "${local.DEPLOYMENT_NAME}-pip"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

data "azurerm_dns_zone" "this" {
  name                = var.ZONE_DNS_NAME
  resource_group_name = var.ZONE_RESOURCE_GROUP
}

resource "azurerm_dns_a_record" "this" {
  name                = local.DEPLOYMENT_NAME
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = data.azurerm_dns_zone.this.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.this.id
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

resource "azurerm_dns_a_record" "mtls" {
  name                = "mtls.${local.DEPLOYMENT_NAME}"
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = data.azurerm_dns_zone.this.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.this.id
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

resource "azurerm_dns_a_record" "tak" {
  name                = "tak.${local.DEPLOYMENT_NAME}"
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = data.azurerm_dns_zone.this.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.this.id
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

resource "azurerm_dns_a_record" "mtls_tak" {
  name                = "mtls.tak.${local.DEPLOYMENT_NAME}"
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = data.azurerm_dns_zone.this.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.this.id
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

resource "azurerm_dns_a_record" "fake" {
  name                = "fake.${local.DEPLOYMENT_NAME}"
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = data.azurerm_dns_zone.this.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.this.id
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

resource "azurerm_dns_a_record" "mtls_fake" {
  name                = "mtls.fake.${local.DEPLOYMENT_NAME}"
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = data.azurerm_dns_zone.this.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.this.id
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

resource "azurerm_dns_a_record" "bl" {
  name                = "bl.${local.DEPLOYMENT_NAME}"
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = data.azurerm_dns_zone.this.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.this.id
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

resource "azurerm_dns_a_record" "mtls_bl" {
  name                = "mtls.bl.${local.DEPLOYMENT_NAME}"
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = data.azurerm_dns_zone.this.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.this.id
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}


resource "azurerm_dns_a_record" "kc" {
  name                = "kc.${local.DEPLOYMENT_NAME}"
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = data.azurerm_dns_zone.this.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.this.id
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

resource "azurerm_dns_a_record" "mtls_kc" {
  name                = "mtls.kc.${local.DEPLOYMENT_NAME}"
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = data.azurerm_dns_zone.this.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.this.id
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}



resource "azurerm_network_security_group" "this" {
  name                = "${local.DEPLOYMENT_NAME}-nsg"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowTAKInput"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8089"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowTAKConnetors"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8443-8446"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowHTTPs"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1005
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowProductAPIs"
    priority                   = 1006
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4625-4626"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowKC"
    priority                   = 1007
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowBL"
    priority                   = 1008
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4666"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

resource "azurerm_network_interface" "this" {
  name                = "${local.DEPLOYMENT_NAME}-nic"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "${local.DEPLOYMENT_NAME}-nicipc"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }

  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}


resource "azurerm_linux_virtual_machine" "this" {
  name                  = "${local.DEPLOYMENT_NAME}-vm"
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
  network_interface_ids = [azurerm_network_interface.this.id]
  size                  = var.VM_SIZE
  depends_on = [
    azurerm_dns_a_record.this, azurerm_dns_a_record.mtls,
    azurerm_dns_a_record.fake, azurerm_dns_a_record.mtls_fake,
    azurerm_dns_a_record.tak, azurerm_dns_a_record.mtls_tak
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = var.VM_DISK_SIZE
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "24_04-lts"
    version   = "latest"
  }

  user_data = base64encode(templatefile("userdata.tftpl", {
    CERTBOT_EMAIL                       = var.CERTBOT_EMAIL
    DEPLOYMENT_DNS                      = trimsuffix(azurerm_dns_a_record.this.fqdn, ".")
    POSTGRES_PASSWORD                   = xkcdpass_generate.postgres_pass.result
    COMP_REPO_URI                       = var.DOCKER_COMPOSITION_REPO
    COMP_REPO_TAG                       = var.DOCKER_REPO_TAG
    VITE_ASSET_SET                      = var.VITE_ASSET_SET
    DOCKER_TAG_EXTRA                    = var.DOCKER_TAG_EXTRA
    DEPLOYMENT_NAME                     = local.DEPLOYMENT_NAME
    RM_DATABASE_PASSWORD                = xkcdpass_generate.rm_db_pass.result
    BL_DATABASE_PASSWORD                = xkcdpass_generate.bl_db_pass.result
    KEYCLOAK_DATABASE_PASSWORD          = xkcdpass_generate.kc_db_pass.result
    KEYCLOAK_ADMIN_PASSWORD             = xkcdpass_generate.kc_admin_pass.result
    KEYCLOAK_HTTPS_KEY_STORE_PASSWORD   = xkcdpass_generate.kc_keystore_pass.result
    KEYCLOAK_HTTPS_TRUST_STORE_PASSWORD = xkcdpass_generate.kc_truststore_pass.result
    LDAP_ADMIN_PASSWORD                 = xkcdpass_generate.kc_ldap_pass.result
    TAK_DATABASE_PASSWORD               = xkcdpass_generate.tak_db_pass.result
    TAKSERVER_CERT_PASS                 = xkcdpass_generate.tak_jks1_pass.result
    TAK_CA_PASS                         = xkcdpass_generate.tak_jks2_pass.result
    EXPIRES                             = local.expires
  }))

  admin_username                  = "azureuser"
  disable_password_authentication = true

  dynamic "admin_ssh_key" {
    for_each = var.SSH_PUBLIC_KEY != "" ? ["this"] : []

    content {
      username   = "azureuser"
      public_key = <<-EOF
      ${var.SSH_PUBLIC_KEY}
      EOF
    }
  }
  tags = {
    "fi.fdf.pilvi.expires" : local.expires
    backup = "nobackup"
  }
}
