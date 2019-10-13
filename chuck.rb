
# clear;ruby chuck.rb

require "./Blog"

#include Blog

def suppress_warnings
    previous_VERBOSE, $VERBOSE = $VERBOSE, nil
    yield
    $VERBOSE = previous_VERBOSE
end

suppress_warnings do
    XMLRPC::Config::ENABLE_NIL_PARSER = true
    XMLRPC::Config::ENABLE_NIL_CREATE = true
end

blog = Blog.new()

t1 = blog._rd(("bob","distsys",str))
puts(t1)

t2 = blog._rd(("alice","gtcn",str))
puts(t2)

poster = "alice"
topic = "gtcn"
messageText = nil
t = [poster, topic, messageText]
puts blog._rd(t)

t3 = blog._rd(("bob","gtcn",str))
puts(t1)
