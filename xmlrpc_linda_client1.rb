
# clear;ruby xmlrpc_linda_client1.rb

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

topic = "testtopic"
poster = "myposter4"
messageText = "my message"

blog = Blog.new()

t = [poster, topic, messageText]
puts blog._out(t)

t = [nil, topic, nil]
puts blog._rd(t)

t = [nil, topic, nil]
puts blog._in(t)