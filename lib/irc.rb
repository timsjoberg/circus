require 'lib/irc/connection'

module Circus
  class IRC
    
    def initialize(options = {})
      @default  = { :server     =>  "za.shadowfire.org",
                    :port       =>  6667,
                    :nick       =>  "Circus-IRC",
                    :username   =>  "circus",
                    :realname   =>  "Using ruby with Circus IRC",
                    :send_speed =>  0.5,
                    :eol        =>  "\r\n" }
      
      @config = @default.merge options
    end
    
    def connect
      @connection ||= Connection.new @config
      
      message :PASS, @config[:password] if @config[:password]
      message :NICK, @config[:nick]
      message :USER, "#{@config[:nick]} 0 * :#{@config[:realname]}"
      
      @connection.connect
    end
    
    def message(type, *arguments)
      self.send type.to_s.downcase.to_sym, arguments
    end
    
    protected
    
    def privmsg(arguments)
      @connection.send "PRIVMSG #{arguments[0]} :#{arguments[1]}"
    end
    
    def action(arguments)
      @connection.send "PRIVMSG #{arguments[0]} :\001ACTION #{arguments[1]}\001"
    end
    
    def join(arguments)
      arguments.each do |channel|
        @connection.send "JOIN #{channel}"
      end
    end
    
    def part(arguments)
      arguments.each do |channel|
        @connection.send "PART #{channel}"
      end
    end
    
    def nick(arguments)
      @connection.send "NICK #{arguments[0]}"
    end
    
    def user(arguments)
      @connection.send "USER #{arguments[0]}"
    end
    
    def pass(arguments)
      @connection.send "PASS #{arguments[0]}"
    end
    
    def topic(arguments)
      @connection.send "TOPIC #{arguments[0]} :#{arguments[1]}"
    end
    
    def kick(arguments)
      while arguments.size < 3
        arguments << ""
      end
      @connection.send "KICK #{arguments[0]} #{arguments[1]} :#{arguments[2]}"
    end
    
  end
end
