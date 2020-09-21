# This file contains the setup configurations for a raspberry pi 4b 64bit (August Beta)
# URL: http://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2020-08-24/

# We have to mange this file because the following options have to be added for k8s
# cgroup_enable=memory
'/boot/cmdline.txt':
  file.managed:
    - source: salt://rpi-4b-64bit/managed_files/cmdline.txt

# Disable hdmi output. Not needed in a headless server
hdmi_off:
  cmd.run:
    - name: tvservice -o