
# clear;ruby bob.rb

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

poster = "bob"

blog = Blog.new()

puts(blog._out(("bob","distsys","I am studying chap 2")))
puts(blog._out(("bob","distsys","The linda example’s pretty simple")))
puts(blog._out(("bob","gtcn","Cool book!")))
