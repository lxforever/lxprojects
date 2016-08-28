#!/usr/bin/env python

import paramiko
host='192.168.122.3'
user='root'
password='redhat'

t=paramiko.Transport((host,22))

t.connect(username=user,password=password)
sftp = paramiko.SFTPClient.from_transport(t)
sftp.get('file2','/tmp/file2')
#sftp.put('test','file2')
t.close()

