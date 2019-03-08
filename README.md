# terraform
Building out an Application Environment in AWS with terraform
The environment will build looks like the diagram below, which has the following features:

A VPC that creates an isolated environment
An Internet Gateway to connect our VPC to the web
An internet facing Application Load Balancer to access our web servers
Public subnets for NAT GW’s and Bastion ASG’s
Private subnets for Web Server ASG’s
NAT GW’s for web servers in the private subnet to access the web
ASG’s running ec2 configured with nginx
ASG running ec2 configured with ubuntu (as our Bastion)


