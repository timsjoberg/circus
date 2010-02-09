module Circus
  class IRC
    
    def initialize(options = {})
      @default  = { :server     =>  "za.shadowfire.org",
                    :port       =>  6667,
                    :nick       =>  "Circus-IRC",
                    :username   =>  "circus",
                    :realname   =>  "Using ruby with Circus IRC",
                    :send_speed =>  0.5 }
      
      @config = @default.merge options
    end
    
    def connect
      @connection ||= Connection.new @config
      
    end
    
    protected
    
    
    
  end
end
