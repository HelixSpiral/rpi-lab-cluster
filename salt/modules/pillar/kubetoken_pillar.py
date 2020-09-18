import os
import re

def ext_pillar(minion_id, pillar, **kw):
		pillarData = {"kubetoken": "N/A"}

		# List the tokens
		stream = os.popen('kubeadm token list')
		splitData = re.split("\s+", stream.read())

		# Grab a token
		for data in splitData:
			if re.match("[a-z0-9]+\.[a-z0-9]", data):
				pillarData["kubetoken"] = data

		return pillarData