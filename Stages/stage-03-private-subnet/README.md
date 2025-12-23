<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

# Creating a Private Subnet

**Project Link:** [View Project](http://learn.nextwork.org/projects/aws-networks-private)

**Author:** Nikola Ivanov  
**Email:** ivanovnikola0021@gmail.com

---

## Creating a Private Subnet

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-private_afe1fdbd)

---

## Introducing Today's Project!

### What is Amazon VPC?

Amazon VPC is a dedicated space on the cloud. It is useful because it creates a separation from other organizations and allows the creation of subnets, ACLs and security groups within it.

### How I used Amazon VPC in this project

In today's project, I used Amazon VPC to create a private subnet and deny its Internet access using a private route table and a private ACL.

### One thing I didn't expect in this project was...

One thing I didn't expect in this project is how easy it would be to separate a network from the other part of the organization and deny its Internet access.

### This project took me...

This project took me an hour.

---

## Private vs Public Subnets

The difference between public and private subnets is that resources in the public subnet have access to the Internet while resources in a private subnet don't. This increases security especially for services that shouldn't be access by anyone.

Having private subnets is useful because important organization resources can be accessed only within that organization network.

My private and public subnets cannot have the same CIDR block as this will create conflicts. Therefore different blocks need to be allocated for both.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-private_afe1fdbd)

---

## A dedicated route table

By default, my private subnet is associated with the default route table.

I had to set up a new route table because the default route table has a route that enables Internet communication which we don't want for our private subnet.

My private subnet's dedicated route table only has one route that allows local traffic therefore disabling Internet communication.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-private_b4b904b5)

---

## A new network ACL

By default, my private subnet is associated with with default NACL.

I set up a dedicated network ACL for my private subnet because the defauilt one accepts all inbound and outbound traffic which we don't want for our  private subnet.

My new network ACL has two simple rules - deny all incoming and outgoing traffic no matter the protocol or IP.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-private_1ed2cb07)

---

---
