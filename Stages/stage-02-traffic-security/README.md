<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

# VPC Traffic Flow and Security

**Project Link:** [View Project](http://learn.nextwork.org/projects/aws-networks-security)

**Author:** Nikola Ivanov  
**Email:** ivanovnikola0021@gmail.com

---

## VPC Traffic Flow and Security

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-security_92b0b0b4)

---

## Introducing Today's Project!

### What is Amazon VPC?

Amazon VPC is a private section of the AWS cloud and it is useful because it separates your resources from other organizations and allow you to apply different rules at the resource and subnet level.

### How I used Amazon VPC in this project

In today's project, I used Amazon VPC to set up a subnet with an internet gateway which had security measures applied through a security group and ACL while also having a route table that would guide the traffic to the correct destination.

### One thing I didn't expect in this project was...

One thing I didn't expect in this project was the amount of levels in which you can set up rules for the traffic.

### This project took me...

This project took me an hour to complete.

---

## Route tables

Route tables are used to manage traffic within a subnet.

Route tables are needed to make a subnet public because the it guides the traffic to the desired destination. If an internet gateway is not associated with the subnet, the traffic won't know where to go.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-security_0a07b191)

---

## Route destination and target

Routes are defined by their destination and target. The destination defines the IP address range that the traffic will reach while the target specifies the route that the traffic will take.

The route in my route table that directs internet-bound traffic to my internet gateway has a destination of 0.0.0.0/0 and a target of igw-0504eba4155738068 which is the newly created gateway.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-security_0a07b191)

---

## Security groups

Security groups are checkpoints that increase security by filtering out traffic that the rules do not permit.

### Inbound vs Outbound rules

Inbound rules are used for incoming traffic. I  configured an inbound rule that allows incoming HTTP requests from all over the world

Outbound rules are applied on outgoing traffic by the devices within the organization. By default, my security group's outbound rule allows all outgoing traffic.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-security_92b0b0b4)

---

## Network ACLs

Network ACLs are traffic filters who limit outgoing and incoming traffic by specific rules.

### Security groups vs. network ACLs

The difference between a security group and a network ACL is that ACLs are set at the subnet level while security groups are applied to specific resources.

---

## Default vs Custom Network ACLs

### Similar to security groups, network ACLs use inbound and outbound rules

By default, a network ACL's inbound and outbound rules will allow all incoming and outgoing. traffic

In contrast, a custom ACL’s inbound and outbound rules are automatically set to deny all.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-security_4faeb056)

---

## Tracking VPC Resources

---

---
