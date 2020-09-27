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
# See salt/rpi-4b-64bit.sls for the changes
apply-rpi-4b-64bit-config:
  salt.state:
    - tgt: {{ pillar['target-minion'] }}
    - sls: rpi-4b-64bit.configure
    - require:
      - salt: set-grain-rpi-4b-64bit