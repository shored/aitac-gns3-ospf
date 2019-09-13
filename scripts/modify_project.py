#!/usr/bin/python3

import json
import sys
import os

import gns3_utils as utils

#def read_projectfile(project_file):
#    pfile = open(project_file, "r")
#    contents = pfile.read()
#    pfile.close()
#    return json.loads(contents)

#def write_projectfile(project_json, project_file):
#    pfile = open(project_file, "w")
#    pfile.write(json.dumps(project_json, indent=4, sort_keys=True))
#    pfile.close()

if __name__ == '__main__':
    args = sys.argv
    if len(args) < 4:
        print("usage:"+args[0]+" <template_project_file> <project_name> <project_id>")
        sys.exit()

    project_json = utils.read_projectfile(args[1])
    project_name = args[2]
    project_id = args[3]
    project_json['name'] = project_name
    project_json['project_id'] = project_id
    project_dir = os.path.dirname(args[1])+"/.."
    utils.write_projectfile(project_json, project_dir+"/"+project_id+"/"+project_name+".gns3")
