# This is the default user on a raspberry pi
pi:
  # Just ensures the user is there, if not it'll get created.
  user.present:
    # Disables password authentication
    - empty_password: True

  # Ensures that ssh auth is setup, copies our key from the ssh_keys folder
  ssh_auth.present:
    - user: pi
    - enc: ssh-rsa
    - comment: pi ssh key
    - source: salt://ssh_keys/pi.id_rsa.pub
    - config: '%h/.ssh/authorized_keys'