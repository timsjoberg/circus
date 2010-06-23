current_dir = File.dirname(__FILE__)

require File.join(current_dir, 'commands')

module Circus
  class Parser
      
      def initialize(event_manager)
        @event_manager = event_manager
      end
      
      def parse(irc_message)
        if irc_message =~ /^(\S+) \:(.+)$/
          symbol = Commands.get_command_symbol $1
          if symbol
            @event_manager.event(symbol, $2)
          else
            puts "UNKNOWN MESSAGE TYPE: #{$2}"
          end
        elsif irc_message =~ /^\:(\S+) (\w+) \:(.+)$/
          symbol = Commands.get_command_symbol $2
          if symbol
            @event_manager.event(symbol, $3, $1)
          else
            puts "UNKNOWN MESSAGE TYPE: #{$2}"
          end
        elsif irc_message =~ /^\:(\S+) (\w+) (\S+)(?: \:?(.+))?$/
          message = $4 || ""
          symbol = Commands.get_command_symbol $2
          
          #TODO: handle subclasses of privmsg e.g. ctcp and action. also subclass of notify ctcp_reply
          
          if symbol
            @event_manager.event(symbol, message, $1, $3)
          else
            puts "UNKNOWN MESSAGE TYPE: #{$2}"
          end
        else
          puts "UNPARSED: #{irc_message}"
        end
      end
      
  end
end
