module Circus
  module Messages
    class Ctcp
      
      def initialize(recipient, message)
        @recipient = recipient
        @message = message
      end
      
      def to_s
        "PRIVMSG #{@recipient} :\001#{@message}\001"
      end
      
    end
  end
end
