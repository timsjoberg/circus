module Circus
  module Messages
    class Mode
      
      def initialize(target, mode, users = nil)
        @target = target
        @mode = mode
        @users = users
      end
      
      def to_s
        if @users
          "MODE #{@target} #{@mode} #{@users}"
        else
          "MODE #{@target} #{@mode}"
        end
      end
      
    end
  end
end
