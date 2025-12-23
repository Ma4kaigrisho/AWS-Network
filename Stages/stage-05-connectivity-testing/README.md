<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

# Testing VPC Connectivity

**Project Link:** [View Project](http://learn.nextwork.org/projects/aws-networks-connectivity)

**Author:** Nikola Ivanov  
**Email:** ivanovnikola0021@gmail.com

---

## Testing VPC Connectivity

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-connectivity_8ee57662)

---

## Introducing Today's Project!

### What is Amazon VPC?

Amazon VPC is a separate space on the cloud, and it is useful because it creates a separation from other organizations and allows the configuration of subnets, ACLs, security groups, and much more within it.

### How I used Amazon VPC in this project

In today's project, I used Amazon VPC to create 2 separate subnets with 2 configurations and then deploy resources on them. Finally I had tested  the connectivity between these resources.

### One thing I didn't expect in this project was...

One thing I didn't expect in this project was the comfort that EC2 Instance Connect creates as it handles the SSH configuration for you.

### This project took me...

This project took me 1 hour to complete.

---

## Connecting to an EC2 Instance

Connectivity means how well resources communicate to each other.

My first connectivity test was whether I could connect to the Public Server.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-connectivity_88727bef)

---

## EC2 Instance Connect

I connected to my EC2 instance using EC2 Instance Connect, which is an easy way to connect to your instance. EC2 Instance Connect handles the connection configuration for you, like key generation and association.

My first attempt at gaining direct access to my public server resulted in an error because the associated security group lacked a rule allowing Inbound SSH traffic.

I fixed this error by adding a rule that allows inbound SSH requests, no matter of the IP address of the source.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-connectivity_1cbb1b88)

---

## Connectivity Between Servers

Ping is a tool used to test connectivity between 2 resources by sending ICMP packets. I used ping to test the connectivity between my Private and Public instances.

The ping command I ran was directed towards the Private instance. By running the ping command, I  attempted to send ICMP packets to the Private instance, and if the transfer was successful, I would have gotten a response back.

The first ping returned no answer from  the Private instance. This meant that the packets weren't reaching their destination.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-connectivity_defghijk)

---

## Troubleshooting Connectivity

I troubleshooted this by configuring the ACL and security group that were associated with the instance to allow ICMP packets, which led to the successful communication between the 2 resources.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-connectivity_4a9e8014)

---

## Connectivity to the Internet

Curl is a tool used to retrieve and upload information to a server,  often used for testing purposes.

I used curl to test the connectivity between my public EC2 instance and the Internet.

### Ping vs Curl

Ping and curl are different because ping sends ICMP packets and is solely used to test connectivity between 2 resources, while curl can also retrieve the information from the server it's used to reach.

---

## Connectivity to the Internet

I ran the curl command curl example.com, which returned the web page's HTML, which was a positive sign that the Public EC2 instance had access to the Internet.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-connectivity_8ee57662)

---

---
