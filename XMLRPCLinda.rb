
require "xmlrpc/server"
require 'xmlrpc/client'
require "./LindaDistributed"
require "./ConverterModule"

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
            
            @server.add_handler(Common.getFullyNamedMethod(:write)) do |topic, poster, message|
                executeLindaFunction(:write, topic, poster, message)
            end

            @server.add_handler(Common.getFullyNamedMethod(:read)) do |topic|
                executeLindaFunction(:read, topic, nil, nil)
            end
            
            @server.add_handler(Common.getFullyNamedMethod(:take)) do |topic|
                executeLindaFunction(:take, topic, nil, nil)
            end
        end

        def executeLindaFunction(method, topic, poster, message)
            begin

                messageObject = Message.new(topic, poster, message)
                lindaVal = @lindaClient.sendMessage(method, topic, messageObject)
                
                messageObject = formatMessageObjectForSerialization(messageObject)

                retVal = { "status" => true, "context" => {"method" => method.to_s, "topic" => topic, "messageObject" => messageObject.to_s}, "lindaVal": lindaVal.to_s }
            rescue StandardError => e 
                puts e.message  
                puts e.backtrace.inspect 
            end
        end
        def formatMessageObjectForSerialization(messageObject)
            # Cannot have nil values so we have to use a string version
            # and convert this on the XML-RPC client that is receiving it.
            messageObject.poster = "nil" if messageObject.poster == nil
            messageObject.messageText = "nil" if messageObject.messageText == nil
            messageObject
        end
    end

    class Server1

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
            @lindaClient = LindaDistributed::Client1.new(@lindaUrl)
            
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
            
            @server.add_handler(Common.getFullyNamedMethod(:take)) do |t|
                process(:take, t)
            end
            @server.add_handler(Common.getFullyNamedMethod(:read)) do |t|
                process(:read, t)
            end
            @server.add_handler(Common.getFullyNamedMethod(:write)) do |t|
                process(:write, t)
            end
        end

        def getMethodInfo(m)
            {:key => m.to_s, :val => m, m => Common.getFullyNamedMethod(m)}
        end

        def process(m, t)
            method = getMethodInfo(m)
            converted = ConverterModule::Converter.xmlRPCTupleToTuple(t)
            output = @lindaClient.send(method[:val], converted)

            if (!output.is_a?(Module.const_get('Array')))
                output = output.to_s
            end

            { "status" => true, "context" => {"method" => method, "input" => t}, "output": output }
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
        def sendMessage2(method, topic, messageObject)

            messageObject = formatMessageObjectForSerialization(messageObject)
            @proxy.call(Common.getFullyNamedMethod(method), topic, messageObject.poster, messageObject.messageText)
        end

        def formatMessageObjectForSerialization(messageObject)
            # Cannot have nil values so we have to use a string version
            # and convert this on the XML-RPC client that is receiving it.
            messageObject.poster = "nil" if messageObject.poster == nil
            messageObject.messageText = "nil" if messageObject.messageText == nil
            messageObject
        end
    end

    class Client1

        @host = nil
        @port = nil
        @proxy = nil

        def initialize(host, port)
            
            @host = host
            @port = port
            path = Common.Path

            @proxy = XMLRPC::Client.new(@host, path, @port)
        end

        def sendMessage(method, tuple)
            @proxy.call(method, tuple)
        end

    end
end