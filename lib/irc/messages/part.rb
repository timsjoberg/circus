module Circus
  module Messages
    class Part
      
      def initialize(channel)
        @channel = channel
      end
      
      def to_s
        "PART #{@channel}"
      end
      
    end
  end
end
