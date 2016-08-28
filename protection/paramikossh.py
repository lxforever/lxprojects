#!/usr/bin/env python

import paramiko
import sys,os

host=sys.argv[1]
user='root'

cmd = sys.argv[2]

s=paramiko.SSHClient()
s.load_system_host_keys()
s.set_missing_host_key_policy(paramiko.AutoAddPolicy())

pkey_file = '/root/.ssh/id_rsa'
key = paramiko.RSAKey.from_private_key_file(pkey_file)

s.connect(host,22,user,pkey=key,timeout=5)
stdin,stdout,stderr=s.exec_command(cmd)

cmd_result = stdout.read(),stderr.read()

for line in cmd_result:

    print line
s.close()

