#!/usr/bin/env python
class tem:
    interval=30
    ll=[1,2,3]
    def __init__(self):
        self.name='liangxu'
        self.test=['lll','mm']
    liangxu='***27033'
class tem1(tem):
    leixue='5499'
a=tem()

a.interval=40

print "tem tem1 interval"
print a.interval
print a.ll,a.name
a.ll.append(77)
print a.test
a.test.append('hello world')
a.name='leixue'
print a.name, a.test
print a.ll
print "+++++++++++tem1"
p=tem1()
print p.interval
print p.ll
print p.name,p.test
