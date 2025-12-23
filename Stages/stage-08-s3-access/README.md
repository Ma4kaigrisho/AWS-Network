<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

# Access S3 from a VPC

**Project Link:** [View Project](http://learn.nextwork.org/projects/aws-networks-s3)

**Author:** Nikola Ivanov  
**Email:** ivanovnikola0021@gmail.com

---

## Access S3 from a VPC

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-s3_3e1e79a2)

---

## Introducing Today's Project!

### What is Amazon VPC?

Amazon VPC is a separate space on the cloud that separates your organization's resources from those of others within the cloud. It is useful because it allows the creation of subnets, ACLs, security groups, Flow Logs, and much more.

### How I used Amazon VPC in this project

In today's project, I used Amazon VPC to create an EC2 instance within a VPC and then connect it to an S3 bucket via the public Internet.

### One thing I didn't expect in this project was...

One thing I didn't expect in this project was the big amount of access key types you can set up for your resources.

### This project took me...

This project took me an hour to complete.

---

## In the first part of my project...

### Step 1 - Architecture set up

In this step, I will set up a VPC and an EC2 instance, as they form the foundation of this project.

### Step 2 - Connect to my EC2 instance

In this step, I will connect to the EC2 instance using EC2 Instance Connect.

### Step 3 - Set up access keys

In this step, I will create and set up access keys for my EC2 instance so that I can access other AWS resources with it.

---

## Architecture set up

I started my project by launching a VPC with all its components, as well as an EC2 instance within that VPC. I also created a new security group for the EC2  instance that will allow inbound SSH.

I also set up an S3 bucket with 2 files, which I will later access from the EC2 instance.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-s3_4334d777)

---

## Running CLI commands

AWS CLI is a command-line tool used to interact with AWS  services. I have access to AWS CLI because EC2 instances have it already installed.

The first command I ran was aws s3 l3 This command is used to list the contents of an S3 bucket. It was unsuccessful because I haven't configured my AWS credentials yet.

The second command I ran was aws configure This command is used to set up the credentials you will be using to interact with AWS services.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-s3_e7fa8776)

---

## Access keys

### Credentials

To set up my EC2 instance to interact with my AWS environment, I configured my access keys using the aws configure command. I provided my access key ID, secret access key, and also the default region name so that it aligns with the region where my resources are.

Access keys are credentials used to log in to AWS.

Secret access keys are the passwords used in pairs with your access key ID to access your IAM user. They should be stored securely, as having access to them will grant permissions to the AWS services within the organization.

### Best practice

Although I'm using access keys in this project, a best practice alternative is to use AWS CLI V2 and AWS CloudShell. 

---

## In the second part of my project...

### Step 4 - Set up an S3 bucket

In this step, I will create an S3 bucket so that I can test if I can access it through the created EC2 instance.

### Step 5 - Connecting to my S3 bucket

In this step, I will interact with the S3 bucket via the EC2 instance.

---

## Connecting to my S3 bucket

The first command I ran was aws s3 l3 This command is used to list the contents of an S3 bucket. It was unsuccessful because I haven't configured my AWS credentials yet.

When I ran the command aws ls s3 again, the terminal responded with the name of the S3 bucket that I created. This indicated that I have set up the access keys and S3 bucket correctly.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-s3_4334d778)

---

## Connecting to my S3 bucket

Another CLI command I ran was "aws s3 ls s3://URL_TO_S3" which returned the images that I had previously uploaded.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-s3_4334d779)

---

## Uploading objects to S3

To upload a new file to my bucket, I first ran the command "sudo touch /tmp/filename". This command created an empty text file which I can upload to my S3 bucket.

The second command I ran was "aws s3 cp /path/to/file s3:/URL/TO/S3"  This command copies the file from the EC2 instance and uploads it to the specified bucket.

The third command I ran was "aws s3 ls s3:URL/TO/S3". This command will once again list the contents of the mentioned bucket, and if everything was executed correctly, the previously uploaded file should be listed as well.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-s3_3e1e79a2)

---

---
