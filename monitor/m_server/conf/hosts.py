
import templates
import copy

#host h1
h1 = templates.LinuxGeneralServices()
h1.services = copy.deepcopy(h1.services)
h1.hostname = 'localhost'
h1.ip_address = '192.168.122.2'
h1.port = 22
h1.os = 'redhat 2-6'
h1.services['cpu'].interval= 38
h1.services['cpu'].triggers['steal'] = [int, 70,75]




#host h2
h2 = templates.LinuxGeneralServices()
h2.services = copy.deepcopy(h2.services)
h2.hostname = 'server3.example.com'
h2.ip_address = '192.168.122.3'
h2.port = 22
h2.os = 'redhat 2-6'
h2.services['load'].interval = 30
h2.services['cpu'].interval = 59
#print h1.ip, h1.services['cpu'].triggers 
#print h2.ip, h2.services['cpu'].triggers 

#host h3
h3 = templates.LinuxGeneralServices()
h3.services = copy.deepcopy(h3.services)
h3.hostname = 'server4.example.com'
h3.ip_address = '192.168.122.4'
h3.port = 22
h3.os = 'redhat 2-6'
h3.services['load'].interval = 30


monitored_hosts = [h1,h2,h3]
#
#print h1.services['cpu'].triggers
#print h1.ip_address,h1.services['cpu'].interval
#print h2.services['cpu'].triggers,h2.services['cpu'].interval
#print h2.ip_address
#
#print '---h2 service\n',h2.services
#print '---h3 service\n',h3.services
#print h3.services['cpu'].triggers,h1.services['cpu'].interval
#print h2.services['cpu'].interval,h3.services['cpu'].interval
