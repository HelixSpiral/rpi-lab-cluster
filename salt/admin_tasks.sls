# This state file contains admin tasks that have to be run on every node
# that aren't classified by another state

# Disable any swapfiles
swap_off:
  cmd.run:
    - name: swapoff -a

# We have to make sure ip forwarding is enabled for ipv4
'/etc/sysctl.conf':
  file.managed:
    - source: salt://managed_files/sysctl.conf