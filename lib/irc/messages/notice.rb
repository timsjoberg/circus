module Circus
  module Messages
    class Notice
      
      def initialize(recipient, message)
        @recipient = recipient
        @message = message
      end
      
      def to_s
        "NOTICE #{@recipient} :#{@message}"
      end
      
    end
  end
end
