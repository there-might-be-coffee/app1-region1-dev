terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 3.0"
        }
    }



}

provider "azurerm" {
  features {}

  skip_provider_registration = true
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}


resource "azurerm_container_group" "example" {
  name                = "example-continst-1313"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-label-643de2ec"
  os_type             = "Linux"

  container {
    name   = "hello-world"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "development"
  }
}

output "fqdn_container_group" {
    value = azurerm_container_group.example.fqdn
}