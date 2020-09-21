# Install Docker
docker.packages:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common
      - docker.io

# Manage the daemon.json for docker
/etc/docker/daemon.json:
  file.managed:
    - source: salt://docker/managed_files/daemon.json

# Enable docker to run on system start
docker_run:
  cmd.run:
    - name: systemctl enable docker.service