#!/usr/bin/env python

products = [ 'apple', 'banana', 'car']
prices = [10,15,5000]
shop_list=[]
salary=int(raw_input("\033[31m please input your salary :\033[0m"))
while True:
    for p in products:
        print p,"\t\t", prices[products.index(p)]
    option=raw_input("what do yo want to buy: ")
    if len(option) == 0: continue
    if option in products:
        p_price = prices[products.index(option)]
        if salary > p_price:
            print "adding %s in shop_list" % option
            shop_list.append(option)
            salary -=p_price
            print "your current balance %d" % salary
        else:
            print "you cannot afford your buy %s" % option
            if salary < min(prices):
                print "too poor to buy anthing form us , fuck out"
                break

