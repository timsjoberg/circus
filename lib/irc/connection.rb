require 'thread'
require 'socket'
require 'irc/parser'

module Circus
  class Connection
    
    def initialize(event_manager, config)
      @parser = Parser.new(event_manager)
      @config = config
      @queue = Queue.new
    end
    
    def connect
      @socket = TCPSocket.open(@config[:server], @config[:port])
      
      @send_thread = Thread.new { dispatch }
      
      begin
        while line = @socket.gets(@config[:eol])
          parse line.chomp
        end
      rescue Interrupt
        @queue.clear
        @queue << "QUIT :Circus-IRC out"
        sleep 1
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
        @socket.write "#{message}#{@config[:eol]}"
        sleep @config[:send_speed]
      end
    end
    
    def parse(line)
      #puts line
      @parser.parse line
    end
    
  end
end
