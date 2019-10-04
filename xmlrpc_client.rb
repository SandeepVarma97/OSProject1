
# clear;ruby xmlrpc_client.rb

require "./XMLRPCLinda"

include XMLRPCLinda

client = Client.new(Common.Host, Common.Port)
puts client.sendMessage2(:write, "testtopic", "testmessage")
puts client.sendMessage1(:read, "testtopic")
puts client.sendMessage1(:take, "testtopic")