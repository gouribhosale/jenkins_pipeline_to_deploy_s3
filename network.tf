# Create an internet gateway for Jenkins VPC
resource "aws_internet_gateway" "jenkins-igw" {
    vpc_id = aws_vpc.jenkins-vpc.id    # Associate the internet gateway with the Jenkins VPC
    tags = {
        Name = "jenkins-igw"           # Assign a name tag to the internet gateway
    }
}

# Define a route table for the public subnet
resource "aws_route_table" "public-jenkins-rt" {
    vpc_id = aws_vpc.jenkins-vpc.id

route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.jenkins-igw.id
    }
    tags = {
        Name = "public-jenkins-rt"
    }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public-subnet-association" {
    subnet_id      = aws_subnet.public-jenkins-subnet.id
    route_table_id = aws_route_table.public-jenkins-rt.id
}


# Create a new security group
resource "aws_security_group" "jenkins-sg" {
	description = "Allows port SSH, HTTP, and Jenkins traffic"
	vpc_id      = aws_vpc.jenkins-vpc.id

	# Define security group rules for Jenkins EC2 instance
	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
	}
	ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from anywhere
	}
	ingress {
		from_port   = 8080
		to_port     = 8080
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]  # Allow Jenkins access from anywhere
	}
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"            # Allow all outbound traffic
		cidr_blocks = ["0.0.0.0/0"]  
	}
	tags = {
		Name = "Jenkins-sg"           # Assign a name tag to the security group
	}

}