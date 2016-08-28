#!/usr/bin/env python
from generic import DefaultService

class cpu(DefaultService):
    def __init__(self):
        self.name = 'cpu'
        self.interval = 60
        self.plugin_name = 'cpu_info'
        self.triggers = {
            'iowait' : ['percentage', 5.5,90],
            'system': ['percentage', 5,90],
            'idle': ['percentage', 20,10],
            'user': ['percentage', 80,90],
            'steal': ['percentage', 80,90],
            'nice': [None, 80,90],
            
        }
        self.temp_data = {
            'iowait' : {'last_item_saving':0, 'status_data': []},
            'system': {'last_item_saving':0, 'status_data': []},
            'idle': {'last_item_saving':0, 'status_data': []},
            'user': {'last_item_saving':0, 'status_data': []},
            'steal':{'last_item_saving':0, 'status_data': []},
            'nice': {'last_item_saving':0, 'status_data': []}
        }
        self.lt_operator=['idle','nice'] # if this sets to empty ,all the status will be caculated in > mode, gt = >
class memory(DefaultService):
    def __init__(self):
        self.name = 'memory'
        self.plugin_name = 'mem_info'
        self.interval = 30
        self.triggers = {
            'SwapUsage_p': ['percentage', 66, 91],
            'MemUsage_p': ['percentage', 20, 92],
        #    'MemUsage': [None, 60, 65],
        }
        self.temp_data={
        
            'SwapUsage_p': {'last_item_saving':0, 'status_data': []},
            'MemUsage_p': {'last_item_saving':0, 'status_data': []},
        }

class load(DefaultService):
    def __init__(self):
        self.name = 'load'
        self.interval = 120
        self.plugin_name = 'load_info'
        self.triggers = {
            'load1': [int, 4,9],
            'load5': [int, 3,7],
            'load15': [int, 3,9],
        }
        self.temp_data={
           'load1' : {'last_item_saving':0, 'status_data': []},
           'load5' : {'last_item_saving':0, 'status_data': []},
           'load15' : {'last_item_saving':0, 'status_data': []},
            
        }
