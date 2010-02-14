$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) ||
  $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'active_support'
require 'irc/connection'

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
    end
    
    def connect
      @connection ||= Connection.new @config
      
      message :PASS, @config[:password] if @config[:password]
      message :NICK, @config[:nick]
      message :USER, "#{@config[:nick]} 0 * :#{@config[:realname]}"
      
      @connection.connect
    end
    
    def message(type, *arguments)
      message_class = type.to_s.downcase.classify
      message_class = "Circus::Messages::#{message_class}"
      message_class = message_class.constantize
      @connection.send message_class.new *arguments
    end
    
    protected
    
  end
end
