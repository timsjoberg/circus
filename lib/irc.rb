$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) ||
  $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'active_support'
require 'irc/connection'
require 'irc/event_manager'

Dir[File.dirname(__FILE__) + "/irc/messages/*.rb"].each do |klass|
  require klass
end

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
      @event_manager = EventManager.new
      
      default_subscriptions
    end
    
    def connect
      @connection ||= Connection.new @event_manager, @config
      
      message :PASS, @config[:password] if @config[:password]
      message :NICK, @config[:nick]
      message :USER, "#{@config[:username]} 0 * :#{@config[:realname]}"
      
      @connection.connect
    end
    
    def message(type, *arguments)
      message_class = type.to_s.downcase.classify
      message_class = "Circus::Messages::#{message_class}"
      message_class = message_class.constantize
      @connection.send message_class.new *arguments
    end
    
    def subscribe(type, &block)
      @event_manager.subscribe(type, &block)
    end
    
    protected
    
    def default_subscriptions
      subscribe(:PING) { |msg| message(:PONG, msg) }
    end
    
  end
end
