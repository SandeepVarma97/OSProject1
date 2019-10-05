
require "rinda/tuplespace"
require "rinda/rinda"

module LindaDistributed
    class Common

        @@Port = 4000
        @@Url = "druby://localhost:#{@@Port}"

        @OList = [:read, :write, :take]
        @@OperationLookup = { 
            @OList[0] => {:key => @OList[0], :tag => "_rd"},
            @OList[1] => {:key => @OList[1], :tag => "_out"},
            @OList[2] => {:key => @OList[2], :tag => "_in"} 
        }

        #method = :read
        #puts @@ol[method][:tag]

        def self.Port
            @@Port
        end
        def self.Url
            @@Url
        end
        def self.OList
            @@OList
        end
        def self.OperationLookup
            @@OperationLookup
        end

    end

    class Server

        def start(url)
            ts = Rinda::TupleSpace.new
            DRb.start_service(url, ts)
            puts "Rinda listening on #{DRb.uri}..."
            DRb.thread.join
        end
    end

    class Client
        
        @url = nil
        @ts = nil

        def initialize(url)
            @url = url
            @ts = DRbObject.new(nil, url)
        end

        def sendMessage(method, topic, message)
            
            tuple = toTuple(method, topic, message)

            puts "method: #{method} tuple: #{tuple}"

            retVal = @ts.send(method, tuple)
        end

        def toTuple(method, topic, message)
            tuple = [topic, (method == :write ? message : nil)]
        end
    end
end