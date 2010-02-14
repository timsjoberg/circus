module Circus
  module Messages
    class Privmsg
      
      def initialize(recipient, message)
        @recipient = recipient
        @message = message
      end
      
      def to_s
        "PRIVMSG #{@recipient} :#{@message}"
      end
      
    end
  end
end
