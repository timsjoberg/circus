module Circus
  class Connection
    
    def initialize(config)
      @config = config
      @queue = Queue.new
    end
    
    def connect
      @socket = TCPSocket.open(@config[:server], @config[:port])
    end
    
    def send(message)
      @queue << message
    end
    
    protected
    
  end
end
