# Ansible IaC

Sources for practice lecture about Infrastructure as Code (IaC) used in SEPA4M33SEP, FEL CVUT. This should be a simple playground for Ansible, it's not recommended for a production usage.

## Requirements

- `ansible`
- `podman` + `podman-compose` or `docker` + `docker-compose`

## Tasks

### Preparation

For simplicity, we will you Ubuntu inside containers. We will have two containers that will be mapped to the local ports 5001 and 5002.

1. Let's get it running
    - Set password for root user, create an `.env` file:

        ```ini
        ROOT_PASSWORD=profinit
        ```

    - Start Ubuntu containers using `podman-compose up` (think about them as two Ubuntu VMs)
    - Connect to the VMs:
        - `ssh root@127.0.0.1 -p 5001` 
        - `ssh root@127.0.0.1 -p 5002` 

2.  Copy our ssh key to VMs
    - (optional) Generate ssh key pair `ssh-keygen -t ed25519`
    - Copy public ssh key to VM
        - `ssh-copy-id -p 5001 root@127.0.0.1`
        - `ssh-copy-id -p 5002 root@127.0.0.1`

### Ansible

1. Check the inventory file `inventory.ini`

2. Execute a ping using ansible `ansible -i inventory.ini vm_servers -m ping`

    ```json
    server1 | SUCCESS => {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python3"
        },
        "changed": false,
        "ping": "pong"
    }
    server2 | SUCCESS => {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python3"
        },
        "changed": false,
        "ping": "pong"
    }
    ```

3. Try simple Ansible playbook to create a `sep-user` on our VMs
    - Add a new user using `ansible-playbook -i inventory.ini vm-users.yml`, notice changed count
    - Try to ssh as a `sep-user` to one of VMs, `ssh sep-user@127.0.0.1 -p 5001`
    - Try to run the playbook again, notice changed count