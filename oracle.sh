#! /bin/bash
sudo apt-get update && apt-get remove openjdk-*
sudo apt-get autoremove && apt-get clean
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
