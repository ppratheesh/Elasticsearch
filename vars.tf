variable "REGION" {default = "us-east-1"}
variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0758a746e73c88fe3"
    }
}
variable "PUBLIC_KEY" {}
variable "PRIVATE_KEY" {}
variable "USER_NAME" {}
