variable "name" {
  description = "Name of the secrets access group this key is for"
  type        = string
}

variable "owner" {
  description = "The team that owns this key"
  type        = string
}

variable "cost_center" {
  description = "The cost center for this key"
  type        = string
  validation {
    condition     = contains(["b2b"], var.cost_center)
    error_message = "Valid values for .cost_center (b2b)."
  }
}

variable "allowed_readers" {
  description = "Namespaced services allowed to decrypt with this key"
  type = list(object(
    {
      namespace = string
      service   = string
    }
  ))

  default = []
}

variable "allowed_reader_roles" {
  description = "A list of roles allowed to decrypt with this key"
  type        = list(string)
  default     = []
}

variable "test_condition_var_one" {
  description = "The first condition variable"
  type        = string
}

variable "test_condition_var_two" {
  description = "The second condition variable"
  type        = string
}

variable "test_condition_var_three" {
  description = "The third condition variable"
  type        = string
}

variable "tf_role" {
  description = "The name of the role allowed to access secrets"
  type        = string
}

variable "protected_owners" {
  description = "Secrets owned by those in this list will not be accessible by the user_roles"
  type        = list(string)
  default     = []
}