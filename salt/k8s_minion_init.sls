# We only want to run this once, and never again
# So we set the kubeinit grain to has_run

{% if salt['grains.get']('kubeinit') != 'has_run' %}

{% endif %}