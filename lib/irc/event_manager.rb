current_dir = File.dirname(__FILE__)

require File.join(current_dir, 'commands')

module Circus
  class EventManager
    
    def initialize
      @subscription_id = "0"
      @subscriptions = {}
      @id_to_symbol = {}
      @block_hash = {}
    end
    
    def subscribe(type, &block)
      type = type.to_s if type.is_a? Fixnum
        
      if type.is_a? String
        if type =~ /^\d+$/
          type = "0#{type}" while type.length < 3
        end
        
        type = Commands.get_command_symbol type
      end
      
      if type.is_a? Symbol
        raise "Unknown message type" unless Commands.is_valid_symbol? type
        
        return add_subscription(type, &block)
      end
      raise "Error in EventManager#subscribe: invalid type parameter"
    end
    
    def event(symbol, message, sender = nil, receiver = nil)
      if @subscriptions[symbol]
        @subscriptions[symbol].each do |event_id|
          if sender.nil? && receiver.nil?
            @block_hash[event_id].call(message)
          elsif receiver.nil?
            @block_hash[event_id].call(message, sender)
          else
            @block_hash[event_id].call(message, sender, receiver)
          end
        end
      end
    end
    
    protected
    
    def add_subscription(type, &block)
      @subscription_id.succ!
      
      if @subscriptions[type]
        @subscriptions[type] << @subscription_id.dup
      else
        @subscriptions[type] = [@subscription_id.dup]
      end
      
      @id_to_symbol[@subscription_id] = type
      @block_hash[@subscription_id] = block
      
      @subscription_id
    end
    
  end
end
