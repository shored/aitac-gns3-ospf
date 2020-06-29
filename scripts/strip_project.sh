#!/bin/sh

. ./configs.txt

if [ $# -ne 1 ]; then
	echo "usage: strip_project <project file>"
	exit 1
fi

if [ ! -d $WORKDIR ]; then
	mkdir $WORKDIR
fi

get_conf_file () {
	echo $PROJECT_DIR/project-files/qemu/$3/hda_disk.qcow2
	sudo qemu-nbd -c /dev/nbd0 $PROJECT_DIR/project-files/qemu/$3/hda_disk.qcow2
	sleep 1
	if [ $2 = 'vyos' ]; then
		sudo mount /dev/nbd0p1 /mnt
	elif [ $2 = 'frr' ]; then
		sudo mount /dev/nbd0p2 /mnt
	fi
	cp $1 $PROJECT_DIR/project-files/qemu/$3/
	sudo umount /mnt
	sudo killall qemu-nbd
}

PROJECT_FILE=$1
PROJECT_DIR=$(dirname $1)

python3 extract_configs.py $1

if [ -f $PROJECT_DIR/images.conf ]; then
	while read line
	do
		get_conf_file $line
	done < $PROJECT_DIR/images.conf
fi

tar -C $PROJECT_DIR/.. --exclude '*.qcow2' -cf - $(basename $PROJECT_DIR) | tar xf - -C $WORKDIR

#sudo qemu-nbd -c /dev/nbd0 ./hda_disk.qcow2
