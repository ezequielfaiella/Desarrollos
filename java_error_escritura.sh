#!/bin/bash
sudo sed '$d' /etc/java-8-openjdk/security/java.policy
sudo sed '$d' /etc/java-8-openjdk/security/java.policy
sudo sed -i '$a permission java.security.AllPermission;' /etc/java-8-openjdk/security/java.policy
sudo sed -i '$a };' /etc/java-8-openjdk/security/java.policy
