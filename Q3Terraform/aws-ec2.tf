provider "aws" {
  region = "us-east-1"
  profile = "ameer" #use this if you have aws profiled or remove this
}

resource "aws_instance" "amazon-linux2" {
    ami = "ami-0022f774911c1d690"
    instance_type = "t2.micro"
    tags = {
      Name = "Hydrus Development VM"
    }
    security_groups = [aws_security_group.traffic_control.name]
    associate_public_ip_address = true
    key_name = "ameer_hydrus"
}

resource "aws_security_group" "traffic_control" {
    name = "Allow Traffic"

    ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_key_pair" "deployer" {
  key_name   = "ameer_hydrus"
  #if you need the privte key let me know. 
  public_key = "ssh-rsa /S2+ng4k7ahXgkBohaYoeSTl/Wo+CHctiKzpOjXXE75Sd9GEF9+UvlnxwEjxHyfQ13F88JiZyDjC/Z4CoSyp7FQrZIrlqWiYP18RrtgNvnGuLCpoOo7OY864fwGskUbMthdZawR9zIHB+UDQ18bNyblh3BylfJVXuQplZDNiDjLd4zllXBmLQW+ccC2ppEirMJ1rluJyVXYtYgPO9LEdOC80vb7YBOcTLB85bsdZs/XCudSCdcqDHRZlKRW0FgCxcsKTPqS7ZULwZ2F7bPyK7WpfQBgCbwnQ1KAF6R43LIC5JzOOQHzHjwkHH5cWmVD87Ud7OUHQ6va8eDK/zR5+qGj38XnPJifcsoNmNz7BItDr/kAMlLcJlZ6yqpejXycsoPtnm/VDb5iloyHHF6CG8r2wghdgLZRRhIaKBrAUwD1Jz/j4Xe6NuzFBAWvbSjdZyWL/qsRcB+93qA/9eT8y0s= ameer@ameer-HP-ProBook-450-G2"
}

output "publicip" {
    value = aws_instance.amazon-linux2.public_ip
  
}