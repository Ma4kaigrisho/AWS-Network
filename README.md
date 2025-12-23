# AWS Network

![image](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/diagram.png?raw=true)

## Inspired by

<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

---

## Overview!

Welcome to my AWS Network. In this project I am demostrating the various networking components you can utilize in a network hosted on the AWS Cloud.

What is included in this project.

The project includes technologies like VPC and its foundational components like subents, ACLs, security groups, route tables. Additionally we take a look at VPC peering, VPC Flow logs and VPC Endpoints. 

Each progression of this project will be separated into its own stage where each stage is an upgrade of the previous one

While this documentation showcases how I created everything from the AWS console, I have also created a Terraform configuration for the whole infrastructure. Go to the bottom of the page to learn more.


## Stages Overview

### Stage one - Build a Virtual Private Cloud

In the very first stage of the project, I set up the initial configuration of the first VPC in the organization
Here I set up the VPC, public subnet and an internet gateway. After that I attach the gateway to the subnet to enable Internet communication

### Stage two - VPC Traffic Flow and Security

The second stage starts where we left off. We add additional components like 
- a route table - Used for pointing the traffic in the right directorin. After its creation, the route table needs to be associated with the subnet.
- security group - Adds security at the instance level.
- a Network ACL - Adds security at the subnet level.

### Stage three - Creating a Private Subnet

Third stage adds an additional subnet to the VPC with its own private route table and private Network ACL.

### Stage four - Launching VPC resources

The fourth stage creates 2 EC2 instances for each of the 2 subnets. The EC2 instances are configured so that they reside in each of the 2 subnets by adding them the proper vpc in the network configuration. Additionnaly we attach the appropriate security groups.

### Stage five - Testing VPC connectivity

This stage is focused on troubleshooting and cofiguring communication between the previously created instances.
We investigate the possible causes for the failed communication between the 2 instances.

### Stage six - VPC peering

In The sixth stage, we create a second VPC and enable private communication between the 2 VPCs utilizing VPC peering and editing the route tables.

### Stage seven - VPC Monitoring with Flow Logs

In this stage we create Flow logs on the first VPC to monitor the inbound and outbound network traffic which is later stored in a CloudWatch log group. I then analyze the logs and their format

### Stage eight - Access S3 from a VPC

This is the first stage where we meet AWS's storage service. We create a bucket, add some content and try to access it via the EC2 instace from the first VPC.

### Stage nine - VPC Endpoints.

The final stage of this project focuses on creating a VPC endpoint which enables private communication between the VPC resources and the S3 bucket. Additionally, we disable any outside access using a bucket policy so that the bucket can be access only through the private endpoint.

---
## Terraform

IN CONSTRUCTION


