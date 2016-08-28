import global_setting
from plugins import upCheck,cpu,load,memory
#def upCheck_info():
#    return upCheck.monitor()

def cpu_info():
    data = cpu.monitor()
    return data

def load_info():
    data = load.monitor()
    return data

def mem_info():
    return memory.monitor()
