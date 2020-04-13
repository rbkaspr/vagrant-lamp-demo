#!/bin/bash

# Update OS
yum update -y --exclude=kernel

# Add dev utils
yum install -y vim unzip git screen nc telnet

