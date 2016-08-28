#!/usr/bin/env python
import json,time
import global_setting
from conf import hosts
import redis_connector as redis
def fetch_monitored_list():
    for h in hosts.monitored_hosts:
        print '\033[42;1m------%s-------\033[0m' %h.hostname
        for service_name,v in h.services.items(): #loop all the monitore services in this host
            print service_name,v.interval
            service_key = '%s::%s' %(h.hostname, service_name)
            service_data = redis.r.get(service_key)
            if service_data is not None:
                service_data = json.loads(service_data)
                time_pass_since_last_recv = time.time() - service_data['recv_time']
                print 'time pass',time_pass_since_last_recv
                if time_pass_since_last_recv >= v.interval + 10:#means haven't receive any data from this service more than the interval time
                    print "\033[41;1mservice %s has no data for %ss\033[0m" % (service_name,time_pass_since_last_recv)
                else:
                    if service_data['data']['status'] == 0: #vaild data
                        for index,val in v.triggers.items():#loop all the indexs in this loop!
                            data_type, warning, critical = val
                            index_val = service_data['data'][index]
                            if data_type == 'percentage' or data_type is int :
                                index_val = float(index_val)
                            #compare part
                            
                            
                            if service_data['recv_time'] != v.temp_data[index]['last_item_saving']: #in_duplicate client data
                                
                                v.temp_data[index]['status_data'].append(index_val)
                                #update old time stamp to new one
                                v.temp_data[index]['last_item_saving'] = service_data['recv_time']
                            # make sure temp data list has no more that nums
                            print "========================="

                            print v.temp_data[index]['status_data']
                            print "========================="
                            if len(v.temp_data[index]['status_data']) > 10:
                                del v.temp_data[index]['status_data'][0]
                            #loop temp data list to check how many nums have crossed threshold
                            cross_warning_count = 0
                            cross_critical_count = 0
                            for item in v.temp_data[index]['status_data']:
                             


                                if index in v.lt_operator: #use < operator fomular
                                    if item < critical:
                                        print "\033[31;1mService %s crossed critical line %s,current val is %s \033[0m" % (index,critical,item)
                                        cross_critical_count += 1

                                    elif item < warning:
                                        print "\033[33;1mService %s crossed warning line %s,current val is %s \033[0m" % (index,warning,item)
                                        cross_warning_count += 1 
                                else: #use >operator
                                    if item > critical:#crossed critical limitation
                                        print "\033[31;1mService %s crossed critical line %s,current val is %s \033[0m" % (index,critical,item)
                                        cross_critical_count += 1
                                    elif item > warning:
                                         print "\033[33;1mService %s crossed warning line %s,current val is %s \033[0m" % (index,warning,item)
                                         cross_warning_count += 1


                            print "\033[44;1m -----temp data length ----\033[0m", service_name,index#v.temp_date[index]['status_data']
                            print "Warning count  :",cross_warning_count
                            print "Critical count :",cross_critical_count
    
                    else:
                        pass
                       #print "\033[31;1m%s data is not vaild \033[0m" % service_name,service_data

            else:
                pass





if __name__ == '__main__':
    while True:
        fetch_monitored_list()
        time.sleep(5)
