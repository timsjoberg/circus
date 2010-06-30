module Circus
  module Messages
    class Raw
      
      def initialize(message)
        @message = message
      end
      
      def to_s
        "#{@message}"
      end
      
    end
  end
end
