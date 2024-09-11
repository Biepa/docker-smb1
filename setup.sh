#!/usr/bin/env bash
set -o nounset
file="/etc/samba/smb.conf"

adduser -D -H "$SMB_USERNAME"&& echo User "$SMB_USERNAME" was added to the system
echo -e "$SMB_PASSWORD\n$SMB_PASSWORD" | smbpasswd -s -a "$SMB_USERNAME"
smbpasswd -e "$SMB_USERNAME" > /dev/null

if [ ! -d /share ] ; then
        mkdir /share
fi
chgrp "$SMB_USERNAME" /share
chown -R "$SMB_USERNAME" /share
  
echo '' >>$file && \
echo "   [$SHARE_NAME]" >>$file && \
echo '   path = /share'  >>$file && \
echo '   browsable = yes'  >>$file && \
echo '   read only = no'  >>$file && \
echo '   guest ok = no'  >>$file && \
echo '   veto files = /.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/'  >>$file && \
echo '   delete veto files = yes'  >>$file && \
echo "   valid users = $SMB_USERNAME"  >>$file

smbd -FS --no-process-group && sleep infinity