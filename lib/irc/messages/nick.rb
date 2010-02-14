$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) ||
  $:.include?(File.expand_path(File.dirname(__FILE__)))

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
