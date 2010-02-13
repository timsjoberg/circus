require 'thread'
require 'socket'

module Circus
  class Connection
    
    def initialize(config)
      @config = config
      @queue = Queue.new
    end
    
    def connect
      @socket = TCPSocket.open(@config[:server], @config[:port])
      
      @send_thread = Thread.new { dispatch }
      
      while line = @socket.gets
        parse line
      end
      
      @send_thread.exit
      @queue.clear
    end
    
    def send(message)
      @queue << message
    end
    
    protected
    
    def dispatch
      loop do
        message = @queue.pop
        puts "writing: #{message}"
        @socket.write "#{message.chomp}\r\n"
        sleep @config[:send_speed]
      end
    end
    
    def parse(line)
      puts line
      if line =~ /^PING\s+:(.*)$/
        @queue << "PONG :#{$1}"
      end
    end
    
  end
end
