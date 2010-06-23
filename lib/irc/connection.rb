require 'thread'
require 'socket'
require 'timeout'

current_dir = File.dirname(__FILE__)

require File.join(current_dir, 'parser')
require File.join(current_dir, 'errors')

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
        loop do
          line = nil
          Timeout::timeout(@config[:timeout]) do
            line = @socket.gets(@config[:eol])
          end
          raise "Socket Closed" unless line
          parse line.chomp
        end
      rescue Timeout::Error
        raise PingTimeout
      rescue Interrupt
        @queue.clear
        @queue << "QUIT :Circus-IRC out"
        sleep 1
      ensure
        @send_thread.exit
        @queue.clear
        @socket.close unless @socket.nil? || @socket.closed?
      end
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
