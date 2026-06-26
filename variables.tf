variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.4.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "The CIDR block for the first public subnet."
  type        = string
  default     = "10.4.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "The CIDR block for the second public subnet."
  type        = string
  default     = "10.4.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "The CIDR block for the first private subnet."
  type        = string
  default     = "10.4.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "The CIDR block for the second private subnet."
  type        = string
  default     = "10.4.4.0/24"
}

variable "prefix_name" {
  description = "The prefix name for resources."
  type        = string
  default     = "muyu"
}