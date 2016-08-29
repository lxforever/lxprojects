#!/usr/bin/env python

import SocketServer
class MyTCPHandler(SocketServer.BaseRequestHandler):
    def handle(self):
        print "got a connection from:" ,self.client_address[0]
        while True:

            self.data = self.request.recv(1024)
            if not self.data:
                print "client is disconnected..." ,self.client_address[0]
                break
            if self.data.split()[0] == 'put':
                print "going to receive file",self.data.split()[1]
                print "__"*20
                f = file('recv/%s' %self.data.split()[1], 'wb')
                self.request.send("readytoreveuvefuke")
                
                while 1:
                    
                    data = self.request.recv(4096)
                    if data == "Filesenddone":

                        print "Transfer is done...."
                        break
                    f.write(data)
                f.close()

if __name__ == '__main__':
    HOST,PORT='192.168.122.2',9997
    server=SocketServer.ThreadingTCPServer((HOST,PORT),MyTCPHandler)
    server.serve_forever()
