#!/usr/bin/python3

import sys
import json
import os

import gns3_utils as utils

WORKDIR='../work_dir'

def extract_nodes(project_json, outfile):
    #return nodes from json
    catalogue = {}

    for node in project_json['topology']['nodes']:
        if node['node_type'] == 'qemu':
            if node['properties']['hda_disk_image'] == 'empty8G.qcow2':
                outfile.write("/mnt/boot/1.1.8/live-rw/config/config.boot"+"\t"+"vyos"+"\t"+node['node_id']+"\n")
            elif node['properties']['hda_disk_image'] == 'frr7.0-vm0.3.qcow2':
                outfile.write("/mnt/etc/frr/frr.conf"+"\t"+"frr"+"\t"+node['node_id']+"\n")
            else:
                outfile.write("unsupported qemu nodes\n")

#        elif node['node_type'] == 'vpcs':
#            print("vpcs")
#            catalogue[node['node_id']] = ['type', 'vpcs']
#        elif node['node_type'] == 'docker':
#            print("docker")
#        else:
#            print("unsupported node")

#        print(json.dumps(node, indent=4, sort_keys=True))

    return

## extract nodes from gns3 project file

if __name__ == '__main__':
    args = sys.argv
    if len(args) < 2:
        print("usage:"+args[0]+" <project_file>")
        sys.exit()

    project_json = utils.read_projectfile(args[1])

    print(os.path.dirname(args[1]))
    outfile = open(os.path.dirname(args[1])+"/images.conf", 'w+')
    extract_nodes(project_json, outfile)
    outfile.close()
