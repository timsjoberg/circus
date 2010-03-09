module Circus
  module Messages
    class Join
      
      def initialize(channel)
        @channel = channel
      end
      
      def to_s
        if @channel =~ /^\#/
          "JOIN #{@channel}"
        else
          "JOIN ##{@channel}"
        end
      end
      
    end
  end
end
