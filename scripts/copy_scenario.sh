#!/bin/sh

SCRIPT_DIR=~/aitac-gns3-ospf/scripts
PROJECT_DIR=/home/gns3/GNS3/projects

if [ $# -ne 2 ]; then
  echo "usage: copy_project <src_project_id> <dst_project_name>"
  exit 1
fi

PROJECT_NAME=$2
SRC_PROJECT_ID=$1
SRC_PROJECT_FILE=$(ls $PROJECT_DIR/$SRC_PROJECT_ID/*.gns3)

new_project_id=$(uuidgen)

PROJECT_FILE=$PROJECT_DIR/$new_project_id/$PROJECT_NAME

## copy template files

cp -R $PROJECT_DIR/$SRC_PROJECT_ID $PROJECT_DIR/$SRC_PROJECT_ID.clone
mv $PROJECT_DIR/$SRC_PROJECT_ID.clone $PROJECT_DIR/$new_project_id
#rm $PROJECT_DIR/$new_project_id/"$OSPF_TEMPLATE_NAME"
#rm $SRC_PROJECT_FILE

# modify sceinario file

cat "$SRC_TEMPLATE_FILE"

DST_PROJECT_FILE=$(ls $PROJECT_DIR/$new_project_id/*.gns3)

python3 $SCRIPT_DIR/modify_project.py "$DST_PROJECT_FILE" $PROJECT_NAME $new_project_id
rm $DST_PROJECT_FILE
chown -R gns3:gns3 $PROJECT_DIR/$new_project_id

# rename project file
#mv "$PROJECT_FILE"

# modify project uuid
# modify project name

## create  images
