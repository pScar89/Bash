#!/bin/bash

DATE=$(date +%b_%d_%y)
mkdir /tmp/backup
TRIES=0

info() {

	echo "$1" | tee -a /mnt/usb/backups/log
}

tar_and_gzip(){
	info $DATE
	info ' '
	info 'Starting backup...'
	info 'Creating archive...'
	
	tar -czf /tmp/backup/$DATE.tar /home/beast | tee -a /mnt/usb/backups/log

	info 'Compressing archive...'

	gzip /tmp/backup/*.tar
}

copy_and_verify(){
	
	info 'Copying to USB...'

	cp /tmp/backup/$DATE.tar.gz /mnt/usb/backups

	info 'Checking integrity...'
	
	HASH=$(sha256sum /tmp/backup/$DATE.tar.gz | cut -d ' ' -f1)
	HASH2=$(sha256sum /mnt/usb/backups/$DATE.tar.gz | cut -d ' ' -f1)

	if [ "$HASH" = "$HASH2" ]
	then
		rm -r /tmp/backup
		info 'The hashes match!'
		info 'Done!'
		info ' '
		info '---------------------------------------'
		info ' '

	else
		info 'The hashes do NOT match, trying again.'
		
		rm /mnt/usb/backups/$DATE.tar.gz
		
		if [ "$TRIES" -le 3 ] 
		then
			let "TRIES++"
			copy_and_verify

		else
			info 'Unable to verify integrity of backup 3 times.'
			rm -r /tmp/backup

		fi
	fi
}

main () {

	tar_and_gzip
	copy_and_verify
}

main