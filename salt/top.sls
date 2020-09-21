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
  # Currently this handles both the salt and k8s master
  # Later we can split this out into roles and target by grain
  # eg: role:salt-master and role:k8s-master
  'rpi-cluster-master':
    - k8s_master_init