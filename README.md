# README

Clone this repo into `/srv` on the machine that will serve as your salt-master

### users.sls

This file sets up our admin user account.
- Insures the user `pi` exists, and creates it if it does not.
- Disables password-based authentication
- Sets up ssh authentication and copies our ssh key over

### cluster_node_config.sls

This file sets up the machine to run a k8s cluster.
- Disables swap files
- Sets up the managed k8s repo
- Installs packages required for docker
- Configures the docker daemon
- Enables the docker service
- Installs k8s

### k8s_master_init.sls

This file runs the kubeadmin init command and then sets a grain to prevent us from running it a second time.