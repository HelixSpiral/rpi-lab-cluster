# This state file contains admin tasks that have to be run on every node
# that aren't classified by another state

# Disable any swapfiles
swap_off:
  cmd.run:
    - name: swapoff -a