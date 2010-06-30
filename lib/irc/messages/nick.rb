module Circus
  module Messages
    class Nick
      
      def initialize(new_nick)
        @new_nick = new_nick
      end
      
      def to_s
        "NICK #{@new_nick}"
      end
      
    end
  end
end
