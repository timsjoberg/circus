current_dir = File.dirname(__FILE__)

require File.join(current_dir, 'commands')

module Circus
  class EventManager
    
    def initialize
      @subscription_id = "0"
      @subscriptions = {}
      @id_to_symbol = {}
      @block_hash = {}
      @mutex = Mutex.new
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
    
    def unsubscribe(subscription_id)
      value = false
      @mutex.synchronize do
        if @id_to_symbol.has_key? subscription_id
          value = remove_subscription subscription_id
        end
      end
      value
    end
    
    def event(symbol, message, sender = nil, receiver = nil)
      @mutex.synchronize do
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
    end
    
    protected
    
    def add_subscription(type, &block)
      id = nil
      
      @mutex.synchronize do
        @subscription_id.succ!
        
        id = @subscription_id.dup
        if @subscriptions[type]
          @subscriptions[type] << id
        else
          @subscriptions[type] = [id]
        end
        
        @id_to_symbol[id] = type
        @block_hash[id] = block
      end
      
      id
    end
    
    #synchronised in caller: #unsubscribe
    def remove_subscription(id)
      symbol = @id_to_symbol[id]
      
      @subscriptions[symbol].delete id
      @id_to_symbol.delete id
      @block_hash.delete id
      
      true
    end
    
  end
end
