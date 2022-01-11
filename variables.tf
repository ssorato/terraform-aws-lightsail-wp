variable "common_tag" {
  type = map(string)
  description = "Common resource tags"
}

variable "ssh_pubkey" {
  type = string
  description = "SSH key public key"
}

variable "bundle_id" {
  type = string
  description = "The LightSail bundle"
}

variable "wp_name" {
  type = string
  description = "The name of the LightSail"
}

variable "cloudwatch_logs_retention" {
  type = number
  description = "CloudWatch log retention days"
  default = 1
}
