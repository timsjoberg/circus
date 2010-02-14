module Circus
  module Messages
    class Join
      
      def initialize(channel)
        @channel = channel
      end
      
      def to_s
        "JOIN #{@channel}"
      end
      
    end
  end
end
