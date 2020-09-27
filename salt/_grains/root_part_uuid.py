import re


def root_part_uuid():
	grains = {}

	file = open('/boot/cmdline.txt', 'r')

	root_part_uuid = re.findall('root=(\S+)', file.readline())

	grains["root_part_uuid"] = root_part_uuid

	return grains