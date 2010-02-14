module Circus
  module Messages
    class Pass
      
      def initialize(password)
        @password = password
      end
      
      def to_s
        "PASS #{@password}"
      end
      
    end
  end
end
