# clear;ruby adapter.rb

require "./XMLRPCLinda"
require "./LindaDistributed"

server = XMLRPCLinda::Server.new(XMLRPCLinda::Common.Port, LindaDistributed::Common.Url)
server.start()