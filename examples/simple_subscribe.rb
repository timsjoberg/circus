require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'lib', 'circus')

irc = Circus::IRC.new

#join a channel
irc.subscribe(:ENDOFMOTD) do
  irc.join "#circus"
end

begin
  puts "connecting..."
  irc.connect
rescue Circus::PingTimeout
  retry
end
