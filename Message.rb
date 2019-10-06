
class Message
    @topic = ""
    @poster = ""
    @messageText = ""

    def initialize(topic, poster, messageText)
        @topic = topic
        @poster = poster
        @messageText = messageText
    end

    def topic
        @topic
    end

    def poster
        @poster
    end
    def poster=(value)
        @poster = value
    end

    def messageText
        @messageText
    end

    def messageText=(value)
        @messageText = value
    end
end