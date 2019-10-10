# clear;ruby linda_distributed_client.rb

require "./LindaDistributed"
require "./Message"

include LindaDistributed

topic = "testtopic"
poster = "myposter1"
messageText = "my message"
messageObject = Message.new(topic, poster, messageText)

client = Client.new(Common.Url)
puts client.sendMessage(:write, topic, messageObject)
puts client.sendMessage(:read, topic, nil)
puts client.sendMessage(:take, topic, nil)
