require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'lib', 'circus')

irc = Circus::IRC.new

begin
  puts "connecting..."
  irc.connect
rescue Circus::PingTimeout
  retry
end
