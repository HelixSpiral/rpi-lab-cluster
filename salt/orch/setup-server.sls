# This sets up a server and gets it ready to be a minion or master

# Run admin tasks
admin-tasks:
  salt.state:
    - tgt: {{ pillar['target-minion'] }}
    - sls: admin_tasks

# Configure users
configure-users:
  salt.state:
    - tgt: {{ pillar['target-minion'] }}
    - sls: users

# Install Docker
install-docker:
  salt.state:
    - tgt: {{ pillar['target-minion'] }}
    - sls: docker/setup

# Install Kubernetes
install-kubernetes:
  salt.state:
    - tgt: {{ pillar['target-minion'] }}
    - sls: kubernetes/install
    - require:
      - salt: admin-tasks
      - salt: install-docker