# We only want to run this once, and never again
# So we set the kubeinit grain to has_run

{% if salt['grains.get']('kubeinit') != 'has_run' %}

'kubeadm init --pod-network-cidr=10.200.0.0/16':
  - cmd.run

kubeinit:
  grains.present:
    - value: has_run

{% endif %}