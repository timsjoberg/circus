module Circus
  module Messages
    class User
      
      def initialize(new_user)
        @new_user = new_user
      end
      
      def to_s
        "USER #{@new_user}"
      end
      
    end
  end
end
