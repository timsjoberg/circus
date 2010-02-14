module Circus
  module Messages
    class Action
      
      def initialize(recipient, message)
        @recipient = recipient
        @message = message
      end
      
      def to_s
        "PRIVMSG #{@recipient} :\001ACTION #{@message}\001"
      end
      
    end
  end
end
