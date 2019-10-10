
# clear;ruby xmlrpc_linda_client.rb

require "./XMLRPCLinda"

include XMLRPCLinda

topic = "testtopic"
poster = "myposter3"
messageText = "my message"
messageObject = Message.new(topic, poster, messageText)

client = Client.new(Common.Host, Common.Port)
puts client.sendMessage2(:write, topic, messageObject)
puts client.sendMessage1(:read, topic)
puts client.sendMessage1(:take, topic)