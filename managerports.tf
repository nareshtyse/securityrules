### Inbound rules for Docker worker nodes
  security_rule {
    name                       = "Allow-Overlay-Network-Traffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "udp"
    source_port_range          = "4789"
    destination_port_range     = "4789"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
 security_rule {
    name                       = "Container-Network-discovery"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "7946"
    destination_port_range     = "7946"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "Container Network discovery "
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "7946"
    destination_port_range     = "7946"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
############################################################################################
#NSG for Manager Node
############################################################################################
resource "azurerm_subnet" "Manager_node" {
  name                 = "${var.Manager_subnet}"
  resource_group_name  = "${azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.vmss.name}"
  address_prefix       = "10.0.3.0/24"
  network_security_group_id = "${azurerm_network_security_group.Manager_node.id}"
}

resource "azurerm_network_security_group" "Manager_node" {
  name                = "${var.network_security_group_Manager}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

## Inbound rules for manager node
  security_rule {
    name                        = "default allow ssh"
    priority                    = 1000
    direction                   = "Inbound" 
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = 22
    source_address_prefix       = "VirtualNetwork"
    destination_address_prefix  = "*"
    
  }
  security_rule {
    name                        = "default allow http"
    priority                    = 1010
    direction                   = "Inbound" 
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = 80
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    
  }
  security_rule {
    name                        = "default allow https"
    priority                    = 1020
    direction                   = "Inbound" 
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = 443
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
   
  }
  security_rule {
    name                        = "AllowVnetInBound"
    priority                    = 1090
    direction                   = "Inbound" 
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "Virtualnetwork"
    destination_port_range      = "Virtualnetwork"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
   
  }
  security_rule {
    name                        = "AllowAzureLoadBalancerInBound"
    priority                    = 1100 
    direction                   = "Inbound" 
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "AzureLoadBalancer"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
   
  }
  security_rule {
    name                        = "DenyAllInbound"
    priority                    = 1200
    direction                   = "Inbound" 
    access                      = "Deny"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
   
  }
#Outbound Rules for Manager 
  security_rule {
    name                        = "AllowVnetOutbound"
    priority                    = 1300
    direction                   = "outbound" 
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "VirtualNetwork"
    destination_port_range      = "VirtualNetwork"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
   
  }
  security_rule {
    name                        = "AllowInternetoutBound"
    priority                    = 1310
    direction                   = "outbound" 
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "Internet"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
   
  }
  security_rule {
    name                        = "DenyAllOutBound"
    priority                    = 1320
    direction                   = "outbound" 
    access                      = "Deny"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
   
  }
  #Rules for Docker manager 
  security_rule {
    name                       = "Overlay Network Traffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "udp"
    source_port_range          = "4789"
    destination_port_range     = "4789"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
 security_rule {
    name                       = "Container Network discovery"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "7946"
    destination_port_range     = "7946"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "Container Network discovery UDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "7946"
    destination_port_range     = "7946"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Secure Docker client communication"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "tcp"
    source_port_range          = "2376"
    destination_port_range     = "2376"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Communication between nodes of dockerswarm from manager" 
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "udp"
    source_port_range          = "2377"
    destination_port_range     = "2377"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "Manager" {
 subnet_id                 = "${azurerm_subnet.Manager_node.id}"
 network_security_group_id  = "${azurerm_network_security_group.Manager_node.id}"
}
