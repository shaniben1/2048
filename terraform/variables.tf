variable "solution_stack_name" {
  type = string
}

variable "tier" {
  type = string
}

variable "vpc_cidr" {
  description = "2048app_vpc_cidr"
  type        = string
  default     = "10.0.0.0/16"
}