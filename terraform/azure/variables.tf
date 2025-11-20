variable "azure_location" {
  description = "The Azure region to deploy to."
  type        = string
  default     = "East US" # Change this to your preferred region
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group."
  type        = string
}

variable "storage_account_name" {
  description = "Globally unique name for the Azure Storage Account."
  type        = string
}
