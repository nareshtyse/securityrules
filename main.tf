############################################################################################
#NSG for Worker Node
############################################################################################
resource "azurerm_resource_group" "test"{
name     = "${var.resource_group_name}"
location = "${var.location}"
}
resource "azurerm_virtual_network" "vmss" {
  name                = "vmss-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
}
resource "azurerm_subnet" "Worker_node" {
  name                 = "${var.existing_subnet}"
  resource_group_name  = "${azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.vmss.name}"
  address_prefix       = "10.0.2.0/24"
  network_security_group_id = "${azurerm_network_security_group.Worker_node.id}"
}
resource "azurerm_network_security_group" "Worker_node" {
  name                = "${var.network_security_group_Worker}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

# Worker node Inbound security rules
  security_rule {
    name                        = "default-allow-ssh"
    priority                    = 100
    direction                   = "Inbound" 
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = 22
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    
  }
  security_rule {
    name                        = "default-allow-http"
    priority                    = 100
    direction                   = "Inbound" 
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = 80
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    
  }
  security_rule {
    name                        = "default-allow-https"
    priority                    = 100
    direction                   = "Inbound" 
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = 443
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
   
  }
   security_rule {
    name                        = "AllowVnetInbound"
    priority                    = 100
    direction                   = "Inbound" 
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
   
  }
   security_rule {
    name                        = "DenyAllAzureLoadBalancerINBound"
    priority                    = 100
    direction                   = "Inbound" 
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
   
  }

#outbound rules for worker nodes
 security_rule {
    name                       = "AllowVnetOutBound"
    priority                   = 1050
    direction                  = "outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
security_rule {
    name                       = "AllowInternetOutBound"
    priority                   = 1060
    direction                  = "outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "Internet"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
security_rule {
    name                       = "DenyAllBound"
    priority                   = 1070
    direction                  = "outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "Worker" {
 subnet_id                 = "${azurerm_subnet.Worker_node.id}"
 network_security_group_id = "${azurerm_network_security_group.Worker_node.id}"
}
