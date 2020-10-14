import os

def ext_pillar(minion_id, pillar, **kw):
	pillarData = {"kubecert": "N/A"}

	if os.path.exists("/etc/kubernetes/pki/ca.crt"):
		# Grab the cert hash
		stream = os.popen('openssl x509 -in /etc/kubernetes/pki/ca.crt -pubkey -noout | openssl pkey -pubin -outform DER | openssl dgst -sha256')
		splitData = stream.read().split()

		pillarData["kubecert"] = splitData[1]

	return pillarData