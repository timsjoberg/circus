require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'lib', 'circus')

irc = Circus::IRC.new

#join a channel
irc.subscribe(:ENDOFMOTD) do
  irc.join "#circus"
end

irc.subscribe(:PRIVMSG) do |message, sender, receiver|
  if sender =~ /^([^!]+)/
    nick = $1
    
    if receiver =~ /^#/
      irc.privmsg receiver, message
    else
      irc.privmsg nick, message
    end
  end
end

begin
  puts "connecting..."
  irc.connect
rescue Circus::PingTimeout
  retry
end
