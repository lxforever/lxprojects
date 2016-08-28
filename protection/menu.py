#!/usr/bin/env python

import os,sys

msg="""
    \033[42;1mWelcome using old boy's auditing system!\033[0m
    """
print msg

host_dic = {
        'root': '192.168.122.3',
        'lx': '192.168.122.4'

}
print host_dic
while True:
    for hostname,ip in host_dic.items():
        print hostname,ip
    try:
        host = raw_input("please choose one server to login  quit is exit :").strip()
        if host == 'quit':
            print "Goodbye"
            break
    except KeybordInterrupt:continue
    except EOFError:continue
    if len(host) == 0:continue
    if not host_dic.has_key(host) :
        print "No host matched, try again."
        continue
    print '\033[32;1mGoing to connect \033[0m',host_dic[host]
    os.system("python demo.py %s" % host_dic[host])
