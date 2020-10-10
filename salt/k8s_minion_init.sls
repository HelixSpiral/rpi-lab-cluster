# We only want to run this once, and never again
# So we set the kubeinit grain to has_run

{% if salt['grains.get']('kubeinit') != 'has_run' %}

# This block of code right here is without a doubt the most ass backwards bullshit I've seen in ages.
# Why do I have to have a namespace variable and a loop to set the namespace variable when all I want is a single value.
# I'm sure this is partially my fault for not being better with python, but what the fuck.
{% set ns = namespace(k8s_master_hostname = "N/A") %}
{% for hostname in salt['mine.get']('kubernetes:k8s-master', 'k8s-master-hostname', 'grain').values() %}
{% set ns.k8s_master_hostname = hostname %}
{% endfor %}

# Run the kubeadm join command
kube_minion_cmd:
  cmd.run:
    - name: kubeadm join {{ ns.k8s_master_hostname }}:6443 --token {{ pillar['kubetoken'] }} --discovery-token-ca-cert-hash sha256:{{ pillar['kubecert'] }}

# Set the grain so we never run this again
kubeinit:
  grains.present:
    - value: has_run

{% endif %}