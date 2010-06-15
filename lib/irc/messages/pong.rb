module Circus
  module Messages
    class Pong
      
      def initialize(message)
        @message = message
      end
      
      def to_s
        "PONG :#{@message}"
      end
      
    end
  end
end
