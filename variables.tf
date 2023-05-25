variable "subnets" {
type = map(any)
description = "list of subnets"
default = {
subnet1 = {
"address_prefix" = ["10.0.1.0/24"]
"name"           = "subnet1"
}
subnet2 = {
"address_prefix" = ["10.0.2.0/24"]
"name"           = "subnet2"
}
subnet3 = {
"address_prefix" = ["10.0.3.0/24"]
"name"           = "subnet1"
}
bastion_subnet = {
"address_prefix" = ["10.0.4.0/24"]
"name"           = "AzureBastionSubnet"
}
}
}

variable "location" {
type = string
description = "location"
default = "southcentralus"
}

variable "business-division" {
type = string
description = "business division"
default = "retail"
}

variable "project-name" {
type = string
description = "project name"
default = "universe"
}

variable "base-name" {
type = string
description = "base name"
default = "testing"
}
