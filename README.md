## VPC Monitoring with Flow Logs

![image](https://github.com/Ma4kaigrisho/AWS-Network/blob/master/diagram.png?raw=true)

<img src="https://cdn.prod.website-files.com/677c400686e724409a5a7409/6790ad949cf622dc8dcd9fe4_nextwork-logo-leather.svg" alt="NextWork" width="300" />

# VPC Monitoring with Flow Logs

**Project Link:** [View Project](http://learn.nextwork.org/projects/aws-networks-monitoring)

**Author:** Nikola Ivanov  
**Email:** ivanovnikola0021@gmail.com

---

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-monitoring_3e1e79a1)

---

## Introducing Today's Project!

### What is Amazon VPC?

Amazon VPC is a private space on the cloud, and it is useful because it allows separation from other organizations and additional features like subnets, ACLs, Flow Logs, etc.

### How I used Amazon VPC in this project

In today's project, I used Amazon VPC to create 2 VPCs with a peering connection and set up VPC Flow Logs to monitor the incoming and outgoing data.

### One thing I didn't expect in this project was...

One thing I didn't expect in this project was that Flow Logs needed additional permissions to write logs to Cloud Watch.

### This project took me...

This project took me 2 hours to complete

---

## In the first part of my project...

### Step 1 - Set up VPCs

In this step, I will create 2 VPCs on which I will set up monitoring later.

### Step 2 - Launch EC2 instances

In this step, I will add an EC2 instance in each VPC so that I can generate traffic.

### Step 3 - Set up Logs

In this step, I will set up monitoring for inbound and outbound traffic.

### Step 4 - Set IAM permissions for Logs

In this step, I will grant permissions to VPC Flow Logs to write logs and send them to CloudWatch, as they don't have the necessary permissions by default.

---

## Multi-VPC Architecture

I started my project by launching 2 VPCs. Each of them has 1 public subnet.

The CIDR blocks for VPCs 1 and 2 are 10.1.0.0/16 and 10.2.0.0/16. They have to be unique in order to prevent IP conflicts between their resources.

### I also launched EC2 instances in each subnet

My EC2 instances' security groups allow ICMP traffic from anywhere. This is because ICMP traffic needs to be allowed to test the communication between the 2 resources.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-monitoring_e7fa8775)

---

## Logs

Logs are records holding information about the activity of a resource.

Log groups are used to group logs of the same type together. Usually, that would be logs from the same resource.

### I also set up a flow log for VPC 1

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-monitoring_e8398869)

---

## IAM Policy and Roles

I created an IAM policy because VPC Flow Logs don't have the necessary permissions to write logs to CloudWatch, and therefore we need to create a policy and attach it to a role.

I also created an IAM role because policies can't be assigned to a service/feature directly. This is done by a role.

A custom trust policy is used to specify which features should be assigned to this role explicitly.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-monitoring_4334d777)

---

## In the second part of my project...

### Step 5 - Ping testing and troubleshooting

In this step, I will test the connectivity between the 2 instances that are on separate VPCs.

### Step 6 - Set up a peering connection

In this step, I will create a VPC peering connection because that will enable private communicati

### Step 7 - Analyze flow logs

In this step, I will analyze the flow logs recorded becau

---

## Connectivity troubleshooting

My first ping test between my EC2 instances had no replies, which means that the VPC peering is not set up. If the instances tried to communicate via their public IP addresses, it would work; however, the communication would go over the Internet.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-monitoring_99d4ba42)

I could receive ping replies if I ran the ping test using the other instance's public IP address, which means everything besides the VPC peering is set up correctly.

---

## Connectivity troubleshooting

Looking at VPC 1's route table, I identified that the ping test with Instance 2's private address failed because there is no peering connection between the 2 VPC, and there are no routes added in the route tables for them.

### To solve this, I set up a peering connection between my VPCs

I also updated both VPCs' route tables so that they know where the traffic going to or coming from the other VPC should go.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-monitoring_7316a13d)

---

## Connectivity troubleshooting

I received ping replies from Instance 2's private IP address! This means that the peering connection is set up correctly.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-monitoring_4ec7821f)

---

## Analyzing flow logs

Flow logs tell us about the source port and IP of the request as well as the destination port and IP. In addition, we can see the time when the transfer started and ended, as well as the used protocol and whether the traffic was allowed or not.

For example, the flow log I've captured tells us that 10.2.7.30 (Instance2) communicated with 10.1.5.234 (Instance1)

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-monitoring_d116818e)

---

## Logs Insights

Logs Insights is a feature that lets you analyze your queries based on given queuries.

I ran the query Top 10 byte transfers by source and destination IP addresses. This query analyzes the size of the data that is being transferred.

![Image](http://learn.nextwork.org/determined_gold_quiet_peafowl/uploads/aws-networks-monitoring_3e1e79a1)

---

---

