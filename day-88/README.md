# Ansible deployment for a simple web server

## Scenario
The Nautilus DevOps team needs a basic web server running on all application servers in Stratos DC. For now, they want a simple static page deployed with Ansible only, without any manual steps on each server.

## Objective
This playbook will:
- install the httpd package on all app servers
- ensure the httpd service is running and enabled
- create or update the default web page at /var/www/html/index.html
- set the correct owner, group, and permissions for the file

## Why this is useful
Using Ansible for this task provides a repeatable and consistent way to configure servers. It removes the need to log in to each machine manually, reduces human error, and makes the setup easy to reproduce in future environments.

## Prerequisites
- Ansible installed on the jump host
- An inventory file available in the same directory as the playbook
- SSH access from the jump host to the target app servers

## How to run
Run the following command from the directory that contains the inventory file and playbook:

```bash
ansible-playbook -i inventory playbook.yml
```

## Real-world context
This pattern is commonly used when teams need to quickly stand up a web server for a simple application, a validation page, or a temporary landing page during deployment or migration activities. Ansible helps automate that process across many servers at once.
