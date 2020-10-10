# We only want to run this once, and never again
# So we set the kubeinit grain to has_run

{% if salt['grains.get']('kubeinit') != 'has_run' %}

kube_minion_cmd:
  cmd.run:
    - name: kubeadm join rpi-cluster-master:6443 --token {{ pillar['kubetoken'] }} --discovery-token-ca-cert-hash sha256:{{ pillar['kubecert'] }}
kubeinit:
  grains.present:
    - value: has_run

{% endif %}