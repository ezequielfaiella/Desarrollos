#!/bin/bash

# Add Tailscale’s package signing key and repository

curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | sudo tee /etc/apt/sources.list.d/tailscale.list

# Install Tailscale

sudo apt-get update
sudo apt-get install tailscale

# Authenticate and connect your machine to your Tailscale network

sudo tailscale up

# You’re connected! You can find your Tailscale IPv4 address by running:

tailscale ip -4
