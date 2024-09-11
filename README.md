# Samba container with SMB1 suppport

Some devices like my old printer/scanner (Canon MB5150) only support deprecated protocols to scan to.
This container sets up a network share that it can access.

## Install
1. Clone repo
2. Adjust username, password, share name and the local path on your system
3. Run `docker compose up -d`