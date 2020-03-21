#AWS Provider
provider "aws" {
    region     = "us-east-1"
    #access_key = "AKIAY674NBQD7JGH2FER"
    #secret_key = "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" 
    shared_credentials_file = "~/.aws/credentials"
    vesion     = "~> 2.9.0"
    profile  =  "default"
}

#terraform {
#  required_version = ">= 0.11.8"
#}
