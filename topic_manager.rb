# clear;ruby tuplespace.rb

require "./LindaDistributed"

include LindaDistributed

server = Server.new
server.start(Common.TopicUrl)