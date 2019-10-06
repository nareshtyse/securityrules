variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  default     = "pardha"
}

variable "location" {
  description = "location"
  default     = "east us"
}

variable "existing_subnet" {
  description = "name of the subnet"
  default = "Worker_subnet"
}
#variable "Manager_subnet" {
#  description = "name of the subnet"
#  default = "manager_subnet"
#}

variable "network_security_group_Worker" {
  description = "network security group name"
  default = "Worker_NSG" 
}
#variable "network_security_group_Manager" {
#  description = "network security group name"
#  default = "Manager_NSG" 
#}

