module Circus
  module Messages
    class Topic
      
      def initialize(channel, topic)
        @channel = channel
        @topic = topic
      end
      
      def to_s
        "TOPIC #{@channel} :#{@topic}"
      end
      
    end
  end
end
