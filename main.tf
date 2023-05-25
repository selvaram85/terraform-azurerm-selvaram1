terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

locals {
  resource_tags = {
    project_name = "mytest",
    category     = "UAT"
  }
 resource_basename = "${var.business-division}-${var.location}-${var.project-name}"
}

resource "azurerm_resource_group" "example" {
  name     = "812-087f6787-create-a-private-module-registry-in-t"
  location = var.location
  tags     = local.resource_tags
}


resource "azurerm_virtual_network" "example" {
  name                = "vnet-${local.resource_basename}-01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}


resource "azurerm_subnet" "example" {
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  for_each             = var.subnets
  name                 = each.value["name"]
  address_prefixes     = each.value["address_prefix"]
}

resource "azurerm_public_ip" "example" {
  name                = "pip-${local.resource_basename}-01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "example" {
  name                = "bastion-${local.resource_basename}-01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.example["bastion_subnet"].id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}


