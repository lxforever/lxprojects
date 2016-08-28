#!/usr/bin/env python
from services import linux
class BaseTemplate:
    name = None
    services = None
    hostname = None
    ip_addr = None
    port = None
    os = None
class LinuxGeneralServices(BaseTemplate):
        name = 'linux general Services'
        services = {
            'cpu' : linux.cpu(),
            'memory' : linux.memory(),
            'load' : linux.load(),
        }

class WindowsGeneralServices(BaseTemplate):
    name = 'Windows General Services'
    services = {
        'cpu' : linux.cpu(),
        'memory' : linux.memory(),
        'load' : linux.load(),
    }
