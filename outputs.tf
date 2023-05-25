output "azure_subnet_id" {
value = {
    for id in keys(var.subnets) : id => azurerm_subnet.example[id].id
}
}

output "public_ip" {
value = azurerm_public_ip.example.ip_address
}
