<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

# VPC Endpoints

**Project Link:** [View Project](http://learn.nextwork.org/projects/aws-networks-endpoints)

**Author:** Nikola Ivanov  
**Email:** ivanovnikola0021@gmail.com

---

## VPC Endpoints

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-endpoints_09bcaa8a)

---

## Introducing Today's Project!

### What is Amazon VPC?

Amazon VPC is a separate space on the cloud, and it is useful because it separates an organization's resources.

### How I used Amazon VPC in this project

In today's project, I used Amazon VPC to create a VPC Endpoint and allow a private connection between an S3 bucket and a VPC.

### One thing I didn't expect in this project was...

One thing I didn't expect in this project was the amount of level at which you can set up policies. That includes the VPC endpoint as wel as the S3 bucket.

### This project took me...

This project took me one hour.

---

## In the first part of my project...

### Step 1 - Architecture set up

In this step, I will create a VPC, EC2 instance, and an S3 bucket because they are the foundation of this project.

### Step 2 - Connect to EC2 instance

In this step, I will test the connectivity to my EC2 instace via the Public Internet. 

### Step 3 - Set up access keys

In this step, I will set up access keys for an IAM user so that I can access other resources via the  AWS CLI.

### Step 4 - Interact with S3 bucket

In this step, I will test the connectivity to the S3 bucket from the EC2 instance.

---

## Architecture set up

I started my project by launchinga VPC with all its components and an EC2 instance.

I also set up an S3 bucket with 2 files within it.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-endpoints_4334d777)

---

## Access keys

### Credentials

To set up my EC2 instance to interact with my AWS environment, I configured my access key ID and its secret key pair. Additionnaly I set up a default region so that it's aligned with the one where my other resources are.

Access keys are credentials that you use to authenticate programmatic access to your AWS organization. Access keys are formed of an Access key ID and a secret key, which should be securely stored and not shared with anyone.

Secret access keys are passwords used to authenticate programmatic access to your AWS resources. They should be stored securely.

### Best practice

Although I'm using access keys in this project, a best practice alternative is to use AWS CloudShell and AWS CLI V2.

---

## Connecting to my S3 bucket

The command I ran was aws s3 ls. This command is used to list the buckets that are created within the organization.

The terminal responded with a list of S3 buckets within the specified region. This indicated that the access keys I set up were configured properly.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-endpoints_4334d778)

---

## Connecting to my S3 bucket

I also tested the command "aws s3 ls s3://bucket-name" which returned the contents of the S3 bucket.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-endpoints_4334d779)

---

## Uploading objects to S3

To upload a new file to my bucket, I first ran the command sudo touch /path/filename.txt. This command creates an empty text file which I will then upload to my bucket.

The second command I ran was aws s3 cp /path/to/file s3:bucket/name. This command will copy the local file and upload it on the S3 bucket.

The third command I ran was aws s3 ls s3://bucket_name. which validated that the text file was successfully uploaded.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-endpoints_3e1e79a2)

---

## In the second part of my project...

### Step 5 - Set up a Gateway

In this step, I will create a VPC endpoint for the S3 bucket so that the 2 resources can communicate directly.

### Step 6 - Bucket policies

I will create a bucket policy that blocks all incoming traffic except that from the Production VPC. This will validate if I have configured the endpoint correctly.

### Step 7 - Update route tables

In this step, I will test if I can access the S3 bucket from the EC2 instance that resides within the VPC.

### Step 8 - Validate endpoint conection

In this step, I will test my connectivity to the S3 bucket one more time because the last attempt was unsuccessful.

---

## Setting up a Gateway

I set up an S3 Gateway, which is a specific endpoint used for an S3 bucket and DynamoDB. It enables direct communication between the VPC resources and the S3 bucket/DynamoDB database without the communication having to go over the Internet.

### What are endpoints?

An endpoint is a way to enable private communication between an AWS resource and a VPC.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-endpoints_09bcaa8a)

---

## Bucket policies

A bucket policy is a special type of IAM policy designed for S3 buckets.

My bucket policy will block all incoming traffic unless it's coming from the VPC endpoint identified by the provided VPC endpoint ID, as specified in the policy.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-endpoints_7316a13d)

---

## Bucket policies

Right after saving my bucket policy, my S3 bucket page showed 'denied access' warnings. This was because I am currently trying to access the S3 bucket from the AWS console through the Public Internet.

I also had to update my route table because the current route table configuration does not redirect traffic to the VPC endpoint, therefore the EC2 instance attempts to make the connection through the Public Internet.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-endpoints_4ec7821f)

---

## Route table updates

To update my route table, I associated the VPC Endpoint with the route table which created a new route in the route table. From now on, every traffic from the EC2 instance that is pointed towards the S3 bucket will go over the VPC endpoint.

After updating my public subnet's route table, my terminal could return the contents of the Production S3 bucket.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-endpoints_d116818e)

---

## Endpoint policies

An endpoint policy is a policy set specifically at the VPC endpoint level. It can be used to instantly switch off incoming trafic if you suspect malicious activity,

I updated my endpoint's policy by switching the Effect value from Allow to Deny. I could see the effect of this right away, because my EC2 instance could not access the S3 bucket.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-endpoints_3e1e79a3)

---

---
