import json

def read_projectfile(project_file):
    pfile = open(project_file, "r")
    contents = pfile.read()
    pfile.close()
    return json.loads(contents)

def write_projectfile(project_json, project_file):
    pfile = open(project_file, "w")
    pfile.write(json.dumps(project_json, indent=4, sort_keys=True))
    pfile.close()
