# Stage 1 - Build a Virtual Private Cloud

## Build a Virtual Private Cloud (VPC)

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-vpc_2facf927)

---
## Stage 1 Introduction

In this stage, I will demonstrate how to create VPC, subnets and also an internet gateway. I'm doing this project to learn cloud networking

### What is Amazon VPC?

Amazon VPC is a private space on AWS and it is useful because you can place your resources there and separate them from other organizations.

In this stage, I used Amazon VPC to create a VPC with the 10.1.0.0/16 CIDR block and then create a subnet while also attaching an internet gateway to it so it can be accessed all over the world.

### Personal reflection

One thing I didn't expect in this project was the simplicity of connecting your network to the internet. AWS have created a very smooth process of exposing your resources globally.

---

## Virtual Private Clouds (VPCs)

### What I did in this step

In this step, I will create a VPC so that I can create a subnet for my resources to acceess the Internet.

### How VPCs work

VPCs are private spaces for organizations to add their resources. This increases security and privacy.

### Why there is a default VPC in AWS accounts

There was a default VPC in my account ever since my AWS account was created. This is because some resources require to be within a VPC in order to function. Without it, there wouldn't be possible to create EC2 instances.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-vpc_2facf927)

### Defining IPv4 CIDR blocks

To set up my VPC, I had to define an IPv4 CIDR block, which is a block of IP addresses. The number after the address which in this case is 16 defines which bits are part of the network and which can be used for devices and subnets.

---

## Subnets

### What I did in this step

In this step, I will create a subnet within the created VPC in order to create separation for my resources.

### Creating and configuring subnets

Subnets are networks within the cloud. There are already subnets existing in my account, one for every availability zone in the current region. This separation is done so that if a single datacenter fails, the others can still function.

### Public vs private subnets

The difference between public and private subnets are that public subnets have access to the internet while private subnets are used for internal communication only. For a subnet to be considered public, it has to have an internet gateway.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-vpc_157c4219)

### Auto-assigning public IPv4 addresses

Once I created my subnet, I enabled the auto-assign public IPv4 option. This setting makes sure that every new device added to the subnet gets a public IP so that it can be reached globally without the need of a manual assignement.

---

## Internet gateways

### What I did in this step

In this step, I will create and set up an internet gateway for the subnet because that is the needed bridge for the network to communicate with the Internet.

### Setting up internet gateways

Internet gateways connect a subnet to the Internet, allowing communication with the resources within that network on a global level.

Attaching an internet gateway to a VPC means that all resources within that VPC will have an Internet connection. If I missed this step then all resources will be able to communicate only internally.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-vpc_4ae90410)

