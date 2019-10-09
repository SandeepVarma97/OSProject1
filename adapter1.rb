# clear;ruby adapter1.rb

require "./XMLRPCLinda"
require "./LindaDistributed"

server = XMLRPCLinda::Server1.new(XMLRPCLinda::Common.Port)
server.start()