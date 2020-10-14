# This file contains the orchestration to setup a raspberry pi node

# We use this to set the sbc grain to rpi-4b-64bit
# We can use this to target the specific rpi nodes later
set-grain-rpi-4b-64bit:
  salt.function:
    - name: grains.append
    - tgt: {{ pillar['target-minion'] }}
    - arg:
      - sbc
      - rpi-4b-64bit

# Update grains so we can use the root_part_uuid
saltutil.sync_grains:
  salt.function:
    - tgt: {{ pillar['target-minion'] }}
    - refresh: True

# We use this to apply some changes specific to rpi 4b 64bit nodes
# See salt/rpi-4b-64bit/configure.sls for the changes
apply-rpi-4b-64bit-config:
  salt.state:
    - tgt: {{ pillar['target-minion'] }}
    - sls: rpi-4b-64bit.configure
    - require:
      - salt: set-grain-rpi-4b-64bit

# We reboot the server so it loads the new /boot/cmdline.txt
minion-reboot:
  salt.function:
    - name: system.reboot
    - at_time: 1
    - tgt: {{ pillar['target-minion'] }}

wait-for-reboot:
  salt.wait_for_event:
    - name: salt/minion/*/start
    - id_list:
      - {{ pillar['target-minion'] }}
    - require:
      - salt: minion-reboot

# Now we also want to run the setup-server orchestration to get the server ready to host k8s
setup-server:
  salt.runner:
    - name: state.orchestrate
    - mods: orch.setup-server
    - pillar:
        target-minion: {{ pillar['target-minion'] }}
    - require:
      - salt: wait-for-reboot