module Circus
  module Messages
    class Kick
      
      def initialize(channel, user, reason = "")
        @channel = channel
        @user = user
        @reason = reason
      end
      
      def to_s
        "KICK #{@channel} #{@user} :#{@reason}"
      end
      
    end
  end
end
