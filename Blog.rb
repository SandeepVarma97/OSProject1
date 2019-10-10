require "./XMLRPCLinda"

include XMLRPCLinda

class Blog
    @client = nil

    def initialize()
        @client = Client1.new(Common.Host, Common.Port)
    end

    def _in(t)
        @client.sendMessage(Common.getFullyNamedMethod(:take), t)
    end
    def _rd(t)
        @client.sendMessage(Common.getFullyNamedMethod(:read), t)
    end
    def _out(t)
        @client.sendMessage(Common.getFullyNamedMethod(:write), t)
    end
end