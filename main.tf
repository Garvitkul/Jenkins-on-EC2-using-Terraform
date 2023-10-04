#create the ec2 instance
resource "aws_instance" "jenkins_instance" {
  ami           = "ami-0cd06e47208c8afd3"
  instance_type = "t2.micro"
  user_data     = file("jenkins.sh")
  tags = {
    name = "Jenkins instance"
  }
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
}

#create a security group
resource "aws_security_group" "jenkins_sg" {
  name   = "allow_tls and ssh"
  vpc_id = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH into instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls_and_ssh"
  }
}

#create s3 bucket
resource "aws_s3_bucket" "alysoncoppola-bucket-2023" {
  bucket = var.bucketname
  tags = {
    Name = "alysoncoppola-bucket-2023"
  }
}
