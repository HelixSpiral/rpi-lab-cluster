# Setup the Kubernetes repo
kube.repo:
  pkgrepo.managed:
    - name: deb https://apt.kubernetes.io/ kubernetes-xenial main
    - file: /etc/apt/sources.list.d/kube.list
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Install Kubernetes
kube.packages:
  pkg.installed:
    - fromrepo: kubernetes-xenial
    - hold: True
    - pkgs:
      - kubelet
      - kubeadm
      - kubectl