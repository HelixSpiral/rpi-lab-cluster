# We only want to run this once, and never again
# So we set the kubeinit grain to has_run

{% if salt['grains.get']('kubeinit') != 'has_run' %}

# Create the cluster
kubeadm_master_command:
  cmd.run:
    - name: kubeadm init --pod-network-cidr=10.200.0.0/16

# Run calico
kubectl_run_calico:
  cmd.run:
    - name: kubectl --kubeconfig /etc/kubernetes/admin.conf apply -f /srv/kubernetes/manifests/calico.yaml
    - reload_pillars: True
    - require:
      - cmd: kubeadm_master_command


kubeinit:
  grains.present:
    - value: has_run

{% endif %}