# AWS Network

![image](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/diagram.png?raw=true)

## Inspired by

<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

---

## Overview

Welcome to my AWS Network. In this project I am demonstrating the various networking components you can utilize in a network hosted on the AWS Cloud.

The project includes technologies like VPC and its foundational components like subnets, ACLs, security groups, route tables. Additionally we take a look at VPC peering, VPC Flow logs and VPC Endpoints. 

Each progression of this project will be separated into its own stage and can be treated as a mini-project of its own where each stage is an upgrade of the previous one.

While the documentation showcases how I create everything from the AWS console, I have also created a Terraform configuration for the whole infrastructure. More information about this at the bottom of the page

## For Recruiters

This project demonstrates hands-on experience designing, securing, monitoring, 
and troubleshooting AWS network infrastructure using real AWS services.

### What this project shows

- Ability to design a Virtual Private Cloud from scratch
- Understanding of AWS traffic flow (routing, security groups, NACLs)
- Experience isolating public and private resources
- Hands-on troubleshooting of network connectivity issues
- Implementation of secure inter-VPC communication
- Monitoring network traffic using VPC Flow Logs
- Secure access to AWS services using VPC Endpoints
- Awareness of least-privilege and private networking best practices

### Skills demonstrated

**AWS Networking**
- VPC design and CIDR planning
- Public vs private subnet architecture
- Route tables, Internet Gateways
- VPC Peering and private routing
- VPC Endpoints (Gateway Endpoints for S3)

**Security**
- Security Groups (instance-level security)
- Network ACLs (subnet-level security)
- Restricting public access to AWS resources
- Private service access without Internet exposure

**Monitoring & Troubleshooting**
- VPC Flow Logs
- CloudWatch log analysis
- Diagnosing failed network connectivity

**Infrastructure as Code**
- Terraform implementation of the full architecture
- Mapping manual AWS Console steps to IaC

### How to review this project

- Start with the **Overview** and architecture diagram above
- Each **Stage** represents a logical evolution of the network
- Detailed implementation notes and screenshots are available per stage
- Terraform code mirrors the final architecture


## Stages Overview

### Stage One - Build a Virtual Private Cloud
📄 [Detailed documentation](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/Stages/stage-01-vpc-basics/README.md)

In the first stage of the project, I set up the initial configuration of the first VPC in the organization
Here I set up the VPC, public subnet and an internet gateway. After that I attach the gateway to the subnet to enable Internet communication

### Stage Two - VPC Traffic Flow and Security
📄 [Detailed documentation](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/Stages/stage-02-traffic-security/README.md)

The second stage starts where we left off. We add additional components like 
- a route table - Used for pointing the traffic in the right direction. After its creation, the route table needs to be associated with the subnet.
- security group - Adds security at the instance level.
- a Network ACL - Adds security at the subnet level.

### Stage Three - Creating a Private Subnet
📄 [Detailed documentation](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/Stages/stage-03-private-subnet/README.md)

Third stage adds an additional subnet to the VPC with its own private route table and private Network ACL.

### Stage Four - Launching VPC resources
📄 [Detailed documentation](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/Stages/stage-04-ec2-resources/README.md)

The fourth stage creates 2 EC2 instances for each of the 2 subnets. The EC2 instances are configured so that they reside in each of the 2 subnets by adding them the proper vpc in the network configuration. Additionally we attach the appropriate security groups.

### Stage Five - Testing VPC connectivity
📄 [Detailed documentation](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/Stages/stage-05-connectivity-testing/README.md)

This stage is focused on troubleshooting and configuring communication between the previously created instances.
We investigate the possible causes for the failed communication between the 2 instances.

### Stage Six - VPC peering
📄 [Detailed documentation](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/Stages/stage-06-vpc-peering/README.md)

In The sixth stage, we create a second VPC and enable private communication between the 2 VPCs utilizing VPC peering and editing the route tables.

### Stage Seven - VPC Monitoring with Flow Logs
📄 [Detailed documentation](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/Stages/stage-07-flow-logs/README.md)

In this stage we create Flow logs on the first VPC to monitor the inbound and outbound network traffic which is later stored in a CloudWatch log group. I then analyze the logs and their format

### Stage Eight - Access S3 from a VPC
📄 [Detailed documentation](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/Stages/stage-08-s3-access/README.md)

This is the first stage where we meet AWS's storage service. We create a bucket, add some content and try to access it via the EC2 instance from the first VPC.

### Stage Nine - VPC Endpoints.
📄 [Detailed documentation](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/Stages/stage-09-vpc-endpoints/README.md)

The final stage of this project focuses on creating a VPC endpoint which enables private communication between the VPC resources and the S3 bucket. Additionally, we disable any outside access using a bucket policy so that the bucket can be access only through the private endpoint.

---
## Terraform

The full project configuration is available as a terraform configuration file. In order for the configuration to work, I created a dedicated IAM user with permissions scoped to the resources required for this project. After that, I generated access keys for the user and used them to run the code.

The file could've utilized the vpc module really well, which would’ve made the configuration a lot shorter, however this was left out deliberately so that I can learn the foundations of each resource and their way of configuration.

A difference that can be spotted from the official documentation is the bucket policy in the final stage. There is an additional condition that allows the terraform user to edit the bucket policy. This is done so that the terraform user can later delete and edit the policy even if they are not making the request from the VPC endpoint.


