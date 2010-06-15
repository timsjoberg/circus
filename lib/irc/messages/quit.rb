module Circus
  module Messages
    class Quit
      
      def initialize(message)
        @message = message
      end
      
      def to_s
        "QUIT :#{@message}"
      end
      
    end
  end
end
