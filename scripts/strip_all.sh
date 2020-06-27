#!/bin/sh

source ./configs.txt

for i in $(find $PROJECT_DIR -maxdepth 1 -type d | tail -n +2)
do
	sh ./strip_project.sh $i/"*.gns3"
done

