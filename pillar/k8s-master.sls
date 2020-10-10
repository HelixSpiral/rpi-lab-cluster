# Sets up a mine function to get the hostname of the k8s master
mine_functions:
  k8s-master-hostname:
    mine_function: network.get_hostname