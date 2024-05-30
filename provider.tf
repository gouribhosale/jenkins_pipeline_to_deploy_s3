# Configure the AWS provider
provider "aws" {
    region  = "eu-west-1"    # Specify the AWS region
    profile = "prismika"     # Optional: Use a named profile for authentication
}