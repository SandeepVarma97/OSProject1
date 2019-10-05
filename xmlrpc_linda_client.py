# clear;python3 xmlrpc_linda_client.py
# clear;python xmlrpc_linda_client.py

import xmlrpc.client

xmlrpcUrl = "http://localhost:8088/"
topic = "hellotopic"
message = "hello world"

with xmlrpc.client.ServerProxy("http://localhost:8088/") as proxy:
    print("write: %s" % str(proxy.LindaDistributed._out(topic, "hellomessage")))
    print("read: %s" % str(proxy.LindaDistributed._rd(topic)))
    print("take: %s" % str(proxy.LindaDistributed._in(topic)))

#import json

#print(json.dumps([1, 2, 3, {'4': 5, '6': 7}], separators=(',', ':')))

#require 'json'

#my_hash = JSON.parse('{"hello": "goodbye"}')
#puts my_hash

#my_hash = {:hello => "goodbye"}
#puts JSON.generate(my_hash)