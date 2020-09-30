# This file contains the orchestration to setup a new k8s minion

# We use this to set the sbc grain to k8s-minion
# We can use this to target the k8s-minion nodes later
set-grain-k8s-minion:
  salt.function:
    - name: grains.append
    - tgt: {{ pillar['target-minion'] }}
    - arg:
      - kubernetes
      - k8s-minion

# We use this to apply some changes specific to k8s-minion nodes
# See salt/k8s_minion_init.sls for the changes
apply-k8s-minion-config:
  salt.state:
    - tgt: {{ pillar['target-minion'] }}
    - sls: k8s_minion_init
    - require:
      - salt: set-grain-k8s-minion