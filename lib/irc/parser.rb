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
          message_type = $2
          sender = $1
          receiver = $3
          
          if symbol == :PRIVMSG #possible subclass to ctcp or even more to action
            if message =~ /^\001(.*)\001$/
              symbol = :CTCP
              message = $1
              if message =~ /^ACTION (.*)$/
                symbol = :ACTION
                message = $1
              end
            end
          elsif symbol == :NOTICE #possible subclass to ctcp_reply
            if message =~ /^\001(.*)\001$/
              symbol = :CTCPREPLY
              message = $1
            end
          end
          
          if symbol
            @event_manager.event(symbol, message, sender, receiver)
          else
            puts "UNKNOWN MESSAGE TYPE: #{message_type}"
          end
        else
          puts "UNPARSED: #{irc_message}"
        end
      end
      
  end
end
