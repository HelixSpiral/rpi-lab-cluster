# Disable any swapfiles
swap_off:
  cmd.run:
    - name: swapoff -a

# Setup the Kubernetes repo
kube.repo:
  pkgrepo.managed:
    - name: deb https://apt.kubernetes.io/ kubernetes-xenial main
    - file: /etc/apt/sources.list.d/kube.list
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Install Docker
docker.packages:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common
      - docker.io

# Manage the daemon.json for docker
/etc/docker/daemon.json:
  file.managed:
    - source: salt://docker/daemon.json

# Enable docker to run on system start
docker_run:
  cmd.run:
    - name: systemctl enable docker.service

# Install Kubernetes
kube.packages:
  pkg.installed:
    - fromrepo: kubernetes-xenial
    - hold: True
    - pkgs:
      - kubelet
      - kubeadm
      - kubectl