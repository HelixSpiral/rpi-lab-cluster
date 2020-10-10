# This file contains the orchestration to setup the k8s master

# We use this to set the sbc grain to k8s-master
# We can use this to target the k8s-master later
set-grain-k8s-master:
  salt.function:
    - name: grains.append
    - tgt: {{ pillar['target-minion'] }}
    - arg:
      - kubernetes
      - k8s-master

# We use this to apply some changes specific to k8s-master nodes
# See salt/k8s_master_init.sls for the changes
apply-k8s-master-config:
  salt.state:
    - tgt: {{ pillar['target-minion'] }}
    - sls: k8s_master_init
    - require:
      - salt: set-grain-k8s-master