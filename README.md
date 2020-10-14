# README

Clone this repo into `/srv` on the machine that will serve as your salt-master

### salt/admin_tasks.sls

This file contains admin tasks not covered by another sls
- Disables swap files

### salt/k8s_master_init.sls

This file runs the kubeadm init command and then sets a grain to prevent us from running it a second time

### salt/k8s_minion_init.sls

This file runs the kubeadm join command and then sets a grain to prevent us from running it a second time

### salt/top.sls

This is the main sls file that specifies which minions get which config files

### salt/users.sls

This file sets up our admin user account.
- Ensures the user `pi` exists, and creates it if it does not
- Disables password-based authentication
- Sets up ssh authentication and copies our ssh key over

### salt/docker/setup.sls

This file contains docker-specific setup
- Installs packages required for docker
- Configures the docker daemon
- Enables the docker service

### salt/kubernetes/install.sls

This file contains kubernetes-specific setup
- Sets up the managed k8s repo
- Installs k8s

### salt/rpi-4b-64bit/rpi-4b-64bit.sls

This file contains some configurations specific to raspberry pi 4b 64bit nodes

# Pillar

### pillar/k8s-master.sls

This sets up a salt mine function to get and store the hostname of the k8s master

### pillar/top.sls

This is the main pillar top file taht specifies which pillars run on which minions

# External Modules

### ext/pillar/kubecert.py

This pillar module grabs the kube cert hash from the certificate generated in `kubeadm init` and stores it in a pillar called `kubecert`

### ext/pillar/kubetoken.py

This pillar module grabs the kube token from the output of `kubeadm token list` and stores it in a pillar called `kubetoken`


# Orchestration

### salt/orch/setup-k8s-master.sls

This orchestration sets up a node as the k8s-master

This is used by running: `sudo salt-run state.orch orch.setup-k8s-master pillar='{"target-minion": "minion-name-here"}'`

### salt/orch/setup-k8s-minion.sls

This orchestration sets up a node as a k8s-minion

This should be used only AFTER you have setup a k8s-master

This is used by running: `sudo salt-run state.orch orch.setup-k8s-minion pillar='{"target-minion": "minion-name-here"}'`

### salt/orch/setup-server.sls

This orchestration gets the server ready to run Kubernetes and Docker by running the following states:
- admin_tasks.sls
- users.sls
- docker/setup.sls
- kubernetes/install.sls

### salt/orch/setup-raspberrypi-4b-64bit.sls

This orchestration sets up a raspberry pi device to be used. 
- Sets the `sbc:rpi-4b-64bit` grain for targeting within salt
- Runs the `rpi-4b-64bit.sls` state
- Reboots the device
- Runs the `setup-server.sls` orchestration

This is used by running: `sudo salt-run state.orch orch.setup-raspberrypi-4b-64bit pillar='{"target-minion": "minion-name-here"}'`

# Kubernetes

### kubernetes/manifests/calico.yaml

This is the calico manifest file needed for networking within the k8s cluster