variable "project" {
  type    = string
  default = "roboshop"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "zone_id" {
  type    = string
  default = "Z09000942IQE9E07VWWVE"
}

variable "zone_name" {
  type    = string
  default = "karthikeya.site"
}

variable "component"{
  type = string # mandatory
}

variable "rule_priority"{
  # mandatory, should be given by user in project
}