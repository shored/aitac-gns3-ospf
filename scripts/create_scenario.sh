#!/bin/sh

SCRIPT_DIR=~/scripts
PROJECT_DIR=~/GNS3/projects
OSPF_TEMPLATE=926385bd-c2f2-4023-b578-34689dfab6d9
OSPF_TEMPLATE_NAME="06_OSPF_ts.gns3"

if [ $# -ne 1 ]; then
  echo "usage: create_project <project_name>"
  exit 1
fi

PROJECT_NAME=$1

project_id=$(uuidgen)

TEMPLATE_FILE=$PROJECT_DIR/$OSPF_TEMPLATE/$OSPF_TEMPLATE_NAME
PROJECT_FILE=$PROJECT_DIR/$project_id/$PROJECT_NAME

## copy template files

cp -R $PROJECT_DIR/$OSPF_TEMPLATE $PROJECT_DIR/$OSPF_TEMPLATE.clone
mv $PROJECT_DIR/$OSPF_TEMPLATE.clone $PROJECT_DIR/$project_id
rm $PROJECT_DIR/$project_id/"$OSPF_TEMPLATE_NAME"

# modify sceinario file

cat "$TEMPLATE_FILE"

python3 $SCRIPT_DIR/modify_project.py "$TEMPLATE_FILE" $PROJECT_NAME $project_id

# rename project file
#mv "$PROJECT_FILE"

# modify project uuid
# modify project name

## create  images
