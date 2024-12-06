#!/bin/sh

# Create FTP
useradd -m $FTP_USER

# Set the password for the FTP user
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

# Start vsftpd in the foreground
exec vsftpd /etc/vsftpd/vsftpd.conf