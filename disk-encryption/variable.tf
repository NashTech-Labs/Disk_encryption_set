variable "resource_group_name" {
    type= string
    default = "disk-resource-group"
}

variable "location" {
    type= string
    default = "eastus"
}


variable "key-vault-name" {
    type= string
    default = "diskkeyvault"
}


variable "sku-name" {
    type= string
    default = "premium"
}


variable "key-vault-key" {
    type= string
    default = "disk-key-vault-key"
}

variable "disk_encryption_set" {
    type= string
    default = "disk"
}


variable "enabled_for_disk_encryption" {
    type= string
    default = true
}


variable "purge_protection_enabled" {
    type= string
    default = true
}

variable "key_type" {
    type= string
    default = "RSA"
}

variable "key_size" {
    type= number
    default = 2048
}



