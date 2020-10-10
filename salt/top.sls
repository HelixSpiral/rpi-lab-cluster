# The main salt sls file

base:
  # Configuration that goes to every node
  '*':
    - users
    - admin_tasks
    - docker.setup
    - kubernetes.install

  # Configurations specific to raspberry pi 4b 64bit nodes
  'sbc:rpi-4b-64bit':
    - match: grain
    - rpi-4b-64bit.configure

  # Configuration for the cluster master
  'kubernetes:k8s-master':
    - match: grain
    - k8s_master_init

  'kubernetes:k8s-minion':
    - match: grain
    - k8s_minion_init