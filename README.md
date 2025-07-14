# Jenkins on AWS EC2 with Terraform

This repository contains Terraform code to automate the provisioning of a Jenkins server on an AWS EC2 instance. This setup simplifies the process of creating a Jenkins environment, allowing you to get up and running with your CI/CD pipelines quickly.

## Project Overview

The Terraform configuration in this project will create the following AWS resources:

* **VPC:** A new Virtual Private Cloud (VPC) to provide an isolated network environment.
* **Subnet:** A public subnet within the VPC.
* **Internet Gateway:** To allow communication between the VPC and the internet.
* **Route Table:** To direct network traffic from the subnet to the Internet Gateway.
* **Security Group:** To act as a virtual firewall, allowing traffic on port 22 (SSH), port 8080 (Jenkins UI), and port 80 (HTTP).
* **EC2 Instance:** An Amazon Linux 2 instance where Jenkins will be installed and run.
* **Elastic IP:** A static public IP address associated with the EC2 instance to ensure the Jenkins URL remains constant.

A user data script (`install_jenkins.sh`) is used to automatically install Jenkins, Java, and start the Jenkins service when the EC2 instance is launched.

## Prerequisites

Before you begin, ensure you have the following installed and configured:

1.  **Terraform:** [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2.  **AWS Account:** An active AWS account.
3.  **AWS CLI:** [Install and configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) with your credentials. Your AWS user should have programmatic access and sufficient permissions to create the resources mentioned above.
4.  **SSH Key Pair:** An existing EC2 key pair in your AWS account to securely connect to the instance. You will need to provide the name of your key pair in the `terraform.tfvars` file.

## How to Use

Follow these steps to deploy Jenkins on AWS:

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone [https://github.com/Garvitkul/Jenkins-on-EC2-using-Terraform.git](https://github.com/Garvitkul/Jenkins-on-EC2-using-Terraform.git)
cd Jenkins-on-EC2-using-Terraform
```

### 2. Configure Variables

Create a `terraform.tfvars` file in the root directory. This file will contain the specific values for your deployment.

```hcl
# terraform.tfvars

aws_region    = "us-east-1"      # Example: "us-west-2", "eu-central-1", etc.
instance_type = "t2.micro"       # Or any other desired instance type
key_name      = "your-key-pair-name" # Replace with your EC2 key pair name
```

### 3. Initialize Terraform

Navigate to the repository's directory in your terminal and run the `init` command. This will download the necessary provider plugins.

```bash
terraform init
```

### 4. Plan the Deployment

Run the `plan` command to see the execution plan. This will show you all the resources that Terraform will create.

```bash
terraform plan
```

### 5. Apply the Configuration

If the plan looks correct, apply the configuration to start provisioning the resources on AWS.

```bash
terraform apply
```

Terraform will ask for confirmation. Type `yes` and press Enter. The process will take a few minutes to complete.

## Accessing Jenkins

Once the `terraform apply` command is finished, you can access your new Jenkins server.

1.  **Get the Public IP:** The public IP address of the EC2 instance will be displayed as an output. You can also retrieve it anytime by running:

    ```bash
    terraform output public_ip
    ```

2.  **Open Jenkins in Browser:** Open your web browser and navigate to `http://<your-public-ip>:8080`.

3.  **Unlock Jenkins:** To unlock Jenkins, you need the initial administrator password. SSH into your EC2 instance using the key pair you specified:

    ```bash
    ssh -i /path/to/your/key.pem ec2-user@<your-public-ip>
    ```

    Once connected, retrieve the password from the following file:

    ```bash
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    ```

    Copy the password from the terminal, paste it into the "Administrator password" field in your browser, and click "Continue".

4.  **Complete Setup:** Follow the on-screen instructions to complete the Jenkins setup by installing the suggested plugins and creating an admin user.

## Cleaning Up

To avoid ongoing charges from AWS, you should destroy the infrastructure when you are finished.

Run the `destroy` command from the same directory where you ran `apply`:

```bash
terraform destroy
```

Terraform will show you all the resources that will be deleted. Type `yes` to confirm and remove all the created resources from your AWS account.

## File Structure

* `main.tf`: The main Terraform file that defines the AWS resources to be created.
* `variables.tf`: Contains the declaration of all the input variables used in `main.tf`.
* `outputs.tf`: Defines the outputs that will be displayed after the infrastructure is successfully created (e.g., the public IP).
* `install_jenkins.sh`: A shell script that is executed on the EC2 instance at launch time to install Jenkins and its dependencies.
* `README.md`: This file, providing instructions and information about the project.
