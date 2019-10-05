# clear;ruby linda_distributed_client.rb

require "./LindaDistributed"

include LindaDistributed

client = Client.new(Common.Url)
puts client.sendMessage(:write, "testtopic", "my message")
puts client.sendMessage(:read, "testtopic", nil)

