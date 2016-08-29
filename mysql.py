import MySQLdb
conn=MySQLdb.connect(host='localhost',user='root',passwd='redhat',db='seminar4')
cur=conn.cursor()
cur.execute("select * from host_list")
#v_list = []
#for i in range(10):
#    vlist.append(("testServer%s" %i, " 192.168.0.%s" %i,"centos" ))
#print v_list
#cur.executemany("insert into host_list values (%s, %s, %s)",v_list)
cur.scroll(8,mode="relative")
print cur.fetchall()
cur.close()
conn.commit()
conn.close()

