<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

# VPC Peering

**Project Link:** [View Project](http://learn.nextwork.org/projects/aws-networks-peering)

**Author:** Nikola Ivanov  
**Email:** ivanovnikola0021@gmail.com

---

## VPC Peering

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-peering_88727bef)

---

## Introducing Today's Project!

### What is Amazon VPC?

Amazon VPC is a separate network on the AWS cloud, and it is useful because it creates a separation from other organizations while allowing features like ACLs and security groups.

### How I used Amazon VPC in this project

In today's project, I used Amazon VPC to create 2 VPCs and enable communication between them using VPC peering.

### One thing I didn't expect in this project was...

One thing I didn't expect in this project was the amount of options that can lead to a failuire in communication.

### This project took me...

This project took me an hour and a half to complete.

---

## In the first part of my project...

### Step 1 - Set up my VPC

In this step, I will create 2 VPCs.

### Step 2 - Create a Peering Connection

In this step, I will create a VPC Peering connection between the  2 VPCs in order to enable communication between them.

### Step 3 - Update Route Tables

In this step, I will change the configuration of the route tables. because they need to know how to communicate with each other.

### Step 4 - Launch EC2 Instances

In this step, I will launch an EC2 instance in each VPC so that I can test the connection between the VPCs.

---

## Multi-VPC Architecture

I started my project by launching 1 public subnet for the first VPC and 1 public subnet for the second VPC.

The CIDR blocks for VPCs 1 and 2 are different from each other. They must be unique because otherwise, IP address overlapping and conflicts will arise.

### I also launched 2 EC2 instances

I didn't set up key pairs for these EC2 instances, as I will only connect to them using EC2 Instance Connect.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-peering_11111111)

---

## VPC Peering

A VPC peering connection is a connection between 2 VPC which enables communication between the resources through their private IP addresses.

VPCs would use peering connections to increase their security by setting up the communication to go through their private connection, limiting the usage of the Internet gateway.

The difference between a Requester and an Accepter in a peering connection is that the Requester VPC sends a peering request while the Accepter has to approve this request.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-peering_1cbb1b88)

---

## Updating route tables

After accepting a peering connection, my VPCs' route tables need to be updated because the traffic won't reach the other VPC if the route table can't redirect it properly.

My VPCs' new routes have a destination of the other VPC's CIDR block. The routes' target was the peering connection that was set up between the VPCs.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-peering_4a9e8014)

---

## In the second part of my project...

### Step 5 - Use EC2 Instance Connect

In this step, I will connect to the EC2 instance that belongs to the first VPC to test the connectivity between the 2 VPCs.

### Step 6 - Connect to EC2 Instance 1

In this step, I will attempt to connect to Instance 1.

### Step 7 - Test VPC Peering

In this step, I will try to communicate from Instance 1 to Instance 2 to verify that they can talk to each other.

---

## Troubleshooting Instance Connect

Next, I used EC2 Instance Connect to connect to the instance, as it's the only possible connection option due to the fact that I didn't set a key pair for the instance.

I was stopped from using EC2 Instance Connect because there was no public IP address associated with the instace.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-peering_7685490c)

---

## Elastic IP addresses

To resolve this error, I set up Elastic IP addresses. Elastic IP addresses are static IP addresses that don't change. The default IP addresses that are set on instances are dynamic and can change when an instance is restarted. Static IPs can be beneficial, as each address change can result in additional downtime until the DNS server manages to change the record.

Associating an Elastic IP address resolved the error because that Elastic IP will act as the public IP address for the instance.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-peering_45663498)

---

## Troubleshooting ping issues

To test VPC peering, I ran the command ping which sends ICMP packets to the target IP address.

A successful ping test would validate my VPC peering connection because a ping command sends an ICMP packet over and a successful execution of the command will mean that the 2 instances see and can communicate with each other.

I had to update my second EC2 instance's security group because its inbound rules didn't allow the transfer of ICMP packets. I added a new rule that allows that type of communication, which resulted in a successful ping.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-peering_7a29d352)

---

---
