<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

# Launching VPC Resources

**Project Link:** [View Project](http://learn.nextwork.org/projects/aws-networks-ec2)

**Author:** Nikola Ivanov  
**Email:** ivanovnikola0021@gmail.com

---

## Launching VPC Resources

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-ec2_8ee57662)

---

## Introducing Today's Project!

### What is Amazon VPC?

Amazon VPC is a separate network on AWS and it is useful because it increases security and allows the creation of subnets, ACLs, gateways and route tables.

### How I used Amazon VPC in this project

I used Amazon VPC to set up resources within my previsouly created subnets where one would be accessed publicy while the other woulkd be accessed only through the public subnet.

### One thing I didn't expect in this project was...

One thing I didn't expect in this project was the resource map option for VPC creation. That option is very useful especially in complex architectures. 

### This project took me...

This project took me around an hour to complete

---

## Setting Up Direct VM Access

Directly accessing a virtual machine means connecting to it through a protocol like SSH or Telnet, allowing you to interact with it as if you were physically accessing it.

### SSH is a key method for directly accessing a VM

SSH traffic means Secure Shell. This protocol is used for secure remote access. While being connected to a resource using SSH, your connection is encrypted and there can't be compromised.

### To enable direct access, I set up key pairs

Key pairs are a pair of public and private key used for externel resource access.

A private key's file format means the format in which the private key will be saved. My private key's file format is .pem

---

## Launching a public server

I had to change my EC2 instance's networking settings by changing the VPC, subnet and security group to the ones  that I manually created.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-ec2_88727bef)

---

## Launching a private server

My private server has its own dedicated security group because the public security group allows access from all over the world which is not a good idea for resources that are meant to be private

My private server's security group's source is the public security group which means that resources that are only part of that security group will be able to access the private instance.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-ec2_4a9e8014)

---

## Speeding up VPC creation

I used an alternative way to set up an Amazon VPC! This time, I created all the subents, gateways and routing tables at once.

A VPC resource map is showcasing all parts of a VPC including subnets, route tables and gateways and shows their connection.

My new VPC has a CIDR block of 10.0.0.0/16. It is possible for my new VPC to have the same IPv4 CIDR block as my existing VPC because they are not connected and therefore can have the same IP addresses. 

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-ec2_1cbb1b88)

---

## Speeding up VPC creation

### Tips for using the VPC resource map

When determining the number of public subnets in my VPC, I had to create them based on the number of Availability Zones. This is done so that every public subnet is placed on a different AZ in order to increase the availability of  the resources. 

The set up page also offered to create NAT gateways, which are gateways that enable Internet access for private subnets which are more secure than regular Internet gateways.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-ec2_8ee57662)

---

---
