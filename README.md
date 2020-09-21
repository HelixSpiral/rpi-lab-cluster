# README

Clone this repo into `/srv` on the machine that will serve as your salt-master

### users.sls

This file sets up our admin user account.
- Ensures the user `pi` exists, and creates it if it does not.
- Disables password-based authentication
- Sets up ssh authentication and copies our ssh key over

### admin_tasks.sls

This file contains admin tasks not covered by another sls
- Disables swap files

### docker/setup.sls

This file contains docker-specific setup
- Installs packages required for docker
- Configures the docker daemon
- Enables the docker service

### kubernetes/install.sls

This file contains kubernetes-specific setup
- Sets up the managed k8s repo
- Installs k8s

### k8s_master_init.sls

This file runs the kubeadmin init command and then sets a grain to prevent us from running it a second time.

### rpi-4b-64bit/rpi-4b-64bit.sls

This file contains some configurations specific to raspberry pi 4b 64bit nodes.

# Pillar

### modules/pillar/kubetoken_pillar.py

This pillar module grabs the kube token from the output of `kubeadm token list` and stores it in a pillar called `kubetoken`.

# Orchestration

### orch/setup-raspberrypi-4b-64bit.sls

This orchestration sets up a raspberry pi device to be used. 
- Sets the `sbc:rpi-4b-64bit` grain for targeting within salt
- Runs the `rpi-4b-64bit.sls` state.

This is used by running: `sudo salt-run state.orch orch.setup-raspberrypi-4b-64bit.sls pillar='{"target-minion": "rpi-cluster-master"}'