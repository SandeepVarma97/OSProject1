class TopicMessage
    @@key = "topic_list"
    @topicList = ""

    def initialize()
    end

    def topicList
        @topicList
    end
    def topicList=(value)
        @topicList = value
    end
end