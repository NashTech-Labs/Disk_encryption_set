# Disk Encryption Set

This Terraform Git repo contains a code that create Disk Encryption Set in Azure.

You can protect your managed disks by using Azure Disk Encryption for Linux VMs, which uses DM-Crypt, or Azure Disk Encryption for Windows VMs, which uses Windows BitLocker, to protect both operating system disks and data disks with full volume encryption.

## Prerequisites

Before you can use this Terraform code, you will need to have the following installed:

- [Terraform]
- [Azure CLI]
- azure account with owner permission.


## Usage

To use this Terraform code

Clone this Git repo to your local machine.

Change into the directory containing the code.

```bash
cd Disk-Encryption

```

Create a new file named `terraform.tfvars` in the same directory as your `.tf` files.

```bash
touch terraform.tfvars
```

Open the file in your preferred text editor.

```bash

nano terraform.tfvars
```

Add your desired inputs to the file in the following format:

```ruby
resource_group_name         = ""
location                    = ""
key-vault-name              = ""
sku-name                    = ""
key-vault-key               = ""
disk_encryption_set         = ""
enabled_for_disk_encryption = 
purge_protection_enabled    = 
key_type                    = ""
key_size                    = 
```
Review the changes that Terraform will make to your Azure resources.


Initialize Terraform in the directory.


terraform init

terraform plan 

terraform apply --auto-approve