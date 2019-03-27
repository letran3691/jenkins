#!/usr/bin/env bash
echo "install epel"
yum -y install epel-release

sleep 2
echo "disable firewalld"
systemctl stop firewalld
systemctl disable firewalld
sleep 2
echo "install java"
yum -y install java-1.8.0-openjdk-devel
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

sleep 2
echo "begin install jenkis"
yum -y install jenkins

sleep 2
echo "start jenkins and reboot host"
systemctl start jenkins && systemctl enbale jenkins && reboot

