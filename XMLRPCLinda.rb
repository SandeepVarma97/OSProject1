
require "xmlrpc/server"
require 'xmlrpc/client'
require "./LindaDistributed"

module XMLRPCLinda
    class Common

        @@Port = 8088
        @@Host = "localhost"
        @@Path = "/"
        @@Namespace = "LindaDistributed"

        def self.Port
            @@Port
        end
        def self.Host
            @@Host
        end
        def self.Path
            @@Path
        end
        def self.Namespace
            @@Namespace
        end
        
        def self.getFullyNamedMethod(method)
            tag = LindaDistributed::Common.OperationLookup[method][:tag]
            "#{@@Namespace}.#{tag}"
        end
    end

    class Server

        @port = nil
        @server = nil
        @lindaUrl = nil
        @lindaClient = nil

        def initialize(port, lindaUrl)
            @port = port
            @lindaUrl = lindaUrl
        end

        def start()

            @server = XMLRPC::Server.new(@port)
            @lindaClient = LindaDistributed::Client.new(@lindaUrl)

            puts "Started At #{Time.now}"
            serverProcessThread = Thread.new{internalStart()}
            serverProcessThread.join
            puts "End at #{Time.now}"
        end

        def internalStart()
            addHandlers()
            @server.serve
        end

        def addHandlers()
            
            @server.add_handler(Common.getFullyNamedMethod(:write)) do |topic, message|
                executeLindaFunction(:write, topic, message)
            end

            @server.add_handler(Common.getFullyNamedMethod(:read)) do |topic|
                message = nil
                executeLindaFunction(:read, topic, message)
            end
            
            @server.add_handler(Common.getFullyNamedMethod(:take)) do |topic|
                message = nil
                executeLindaFunction(:take, topic, message)
            end
        end

        def executeLindaFunction(method, topic, message)
            begin

                lindaVal = @lindaClient.sendMessage(method, topic, message)
                
                # Cannot have nil values so we have to use a string version
                # and convert this on the XML-RPC client that is receiving it.
                message = "nil" if message == nil

                retVal = { "status" => true, "context" => {"method" => method.to_s, "topic" => topic, "message" => message}, "lindaVal": lindaVal.to_s }
            rescue StandardError => e 
                puts e.message  
                puts e.backtrace.inspect 
            end
        end
    end

    class Client

        @host = nil
        @port = nil
        @proxy = nil

        def initialize(host, port)
            
            @host = host
            @port = port
            path = Common.Path

            @proxy = XMLRPC::Client.new(@host, path, @port)
        end

        def sendMessage(method)
            @proxy.call(Common.getFullyNamedMethod(method))
        end
        def sendMessage1(method, topic)
            @proxy.call(Common.getFullyNamedMethod(method), topic)
        end
        def sendMessage2(method, topic, message)
            @proxy.call(Common.getFullyNamedMethod(method), topic, message)
        end

    end
end