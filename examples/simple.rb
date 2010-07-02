require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'lib', 'circus')

irc = Circus::IRC.new
irc.connect
