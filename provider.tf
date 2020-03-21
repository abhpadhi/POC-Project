#AWS Provider
provider "aws" {
    region     = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    version     = "~> 2.53.0"
    profile  =  "default"
}

#terraform {
#  required_version = ">= 0.11.8"
#}
