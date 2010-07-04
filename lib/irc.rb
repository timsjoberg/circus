require 'active_support/inflector'

current_dir = File.dirname(__FILE__)

require File.join(current_dir, 'irc', 'connection')
require File.join(current_dir, 'irc', 'event_manager')

Dir[File.join(current_dir, 'irc', 'messages', '*.rb')].each do |klass|
  require klass
end

module Circus
  class IRC
    
    def initialize(options = {})
      @default  = { :server     =>  "irc.freenode.net",
                    :port       =>  6667,
                    :nick       =>  "Circus-IRC",
                    :username   =>  "circus",
                    :realname   =>  "Using ruby with Circus IRC",
                    :send_speed =>  0.5,
                    :timeout    =>  15*60, #15 minutes
                    :eol        =>  "\r\n",
                    :debug      =>  false }
      
      @config = @default.merge options
      @event_manager = EventManager.new
      
      default_subscriptions
    end
    
    def connect
      @connection ||= Connection.new @event_manager, @config
      
      pass @config[:password] if @config[:password]
      nick @config[:nick]
      user "#{@config[:username]} 0 * :#{@config[:realname]}"
      
      @connection.connect
    end
    
    def subscribe(type, &block)
      @event_manager.subscribe(type, &block)
    end
    
    %w(server port nick username realname send_speed timeout eol debug password).each do |config_value|
      define_method("#{config_value}=".to_sym) do |new_value|
        @config[config_value.to_sym] = new_value
      end
    end
    
    def method_missing(name, *args)
      message_class = "Circus::Messages::#{name.to_s.downcase.classify}"
      message_class = message_class.constantize
      @connection.send message_class.new *args
    rescue
      super
    end
    
    protected
    
    def default_subscriptions
      subscribe(:PING) { |msg| pong msg }
    end
    
  end
end
