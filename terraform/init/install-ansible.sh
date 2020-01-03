#!/bin/bash
sudo su
hostnamectl set-hostname ansible-server

#Disable Selinux
setenforce 0
getenforce > /tmp/install_status.log

yum list
#yum update -y
yum install -y git.x86_64
dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf -y install --enablerepo epel-playground ansible
yum install -y python2-PyMySQL
cd /tmp
#git clone https://github.com/mschirbel/terraform-ansible.git
git clone https://github.com/FixHarDeZ/terraform-ansible-master
cd terraform-ansible-master/ansible

#Add web01 ip to ansible
sed -i -e "/^.*Ex 1.*/a [webserver]\n${web01_address}" /etc/ansible/hosts

#Add db01 ip to ansible
sed -i -e "/^.*Ex 1.*/a [database]\n${db01_address}" /etc/ansible/hosts

chmod 400 /home/ec2-user/.ssh/fix-key.pem

echo "Install ansible completed!!!
Run with ec2-user
ansible -m ping all --key-file \"~/.ssh/fix-key.pem\"
ansible-playbook /tmp/terraform-ansible-master/ansible/site.yml --key-file \"~/.ssh/fix-key.pem\"" >> /tmp/install_status.log
