# Define the AWS VPC
resource "aws_vpc" "jenkins-vpc" {
    # Specify the CIDR block for the VPC
    cidr_block = "10.0.0.0/16"
    
    # Enable DNS support for the VPC
    enable_dns_support = true
    
    # Enable DNS hostnames for the VPC
    enable_dns_hostnames = true

    # Add tags to the VPC for identification
    tags = {
        Name = "jenkins-vpc"
    }
}

# Define the public subnet within the VPC
resource "aws_subnet" "public-jenkins-subnet" {
    # Associate the public subnet with the VPC using its ID
    vpc_id            = aws_vpc.jenkins-vpc.id
    
    # Specify the CIDR block for the public subnet
    cidr_block        = "10.0.1.0/24"
    
    # Specify the availability zone for the public subnet
    availability_zone = "eu-west-1a"

   # Ensure that instances launched in this subnet will have public IP addresses
    map_public_ip_on_launch = true

    # Add tags to the public subnet for identification
    tags = {
        Name = "public-jenkins-subnet"
    }
}