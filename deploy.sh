#!/bin/bash

DATE=`date '+%Y-%m-%d %H:%M:%S'`

create_backup () {
	echo "Backing up current version..."
	sudo tar -czvf "/var/archive/${DATE}_backup.tar.gz" "/var/www/webhost"
	echo "Back up complete."
}

echo "Are you sure that you want to deploy this version? (y/n)"
read -n 1 yn

if [ "$yn" != "y" ]; then
	echo "Aborting."
	exit 0
fi

create_backup

echo "Copying new files..."
sudo cp "webhost.py" "/var/www/webhost"
echo "File copy complete."

echo "Restarting services..."
sudo systemctl restart uwsgi
echo "Services restart complete."
