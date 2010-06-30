module Circus
  module Messages
    class CtcpReply
      
      def initialize(recipient, message)
        @recipient = recipient
        @message = message
      end
      
      def to_s
        "NOTICE #{@recipient} :\001#{@message}\001"
      end
      
    end
  end
end
