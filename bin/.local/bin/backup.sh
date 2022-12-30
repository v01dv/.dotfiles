#!/bin/bash
#
# You can also add the option --dry-run to simulate the backup process.
# The command to restore your system is shorter:
# sudo rsync -aAXv --delete --exclude="lost+found" /backup /system
#
# To see more options run: rsync --help

DATE=$(date '+%F')

# sudo rsync --dry-run -aAXv --log-file="rsync.log" --delete --exclude={"/home/voldv/.cache/*","/lost+found"} /home/voldv/ /mnt/synology/inbox/_backup/bak-artix/$DATE
# rsync -aAXvhP --log-file="rsync.log" --delete --exclude={.cache,.cargo,Trash,node_modules} /home/voldv /mnt/synology/inbox/backup/artix/$DATE
rsync -aAXvhP --log-file="rsync.log" --delete --exclude={.cache,.cargo,Trash,node_modules} /home/voldv /mnt/usbstick/


# This is what I use:
# sudo rsync --recursive --times --perms --owner --group --executability --acls
#  --xattrs --delete --delete-excluded --checksum --links --hard-links 
# --specials --devices --human-readable  --progress --verbose --stats 
# --protect-args --log-file="rsync.log" [excluded] [src] [dest]
# will appreciated if I can know your opinion
#
# Btw: on the restoring part --delete will specifies: "delete extraneous files from dest dirs", 
# if there is any file(s)/dir not exist in the source but exist in the dest will be deleted from 
# the dest , the reason is to make it sync
