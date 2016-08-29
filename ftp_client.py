import socket
import time
HOST = '192.168.122.2'
PORT = 9997
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect((HOST,PORT))
while 1:
	user_input=raw_input("your msg: ").strip()
	if len(user_input) == 0:continue

	s.sendall(user_input)
	data = s.recv(1024)
	if data == 'readytoreveuvefuke':
		with open(user_input.split()[1]) as f:
			s.sendall(f.read())
			time.sleep(0.5)	
			s.send("Filesenddone")
	print data
s.close()
