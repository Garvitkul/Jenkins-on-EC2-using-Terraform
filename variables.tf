#define the region
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

#define instance ami
variable "ami_id" {
  description = "ami id for instance"
  type        = string
  default     = "ami-0cd06e47208c8afd3"
}

#define instance type
variable "jenkins_instance" {
  description = "instance_type"
  type        = string
  default     = "t2.micro"
}

#define s3
variable "bucketname" {
  description = "private jenkins bucket"
  type        = string
  default     = "garvit-bucket-2023"
}

#define the key pair
variable "key_pair" {
  description = "key_pair"
  type        = string
  default     = "us-east-kp"
}

#define the VPC id
variable "vpc_id" {
  description = "jenkins_vpc_id"
  type        = string
  default     = "vpc-0c19b870cf7c29df9"
}
