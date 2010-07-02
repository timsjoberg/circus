require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Circus::IRC, "#new without parameters" do
  before(:each) do
    @irc = Circus::IRC.new
  end
  
  it "defines default values if none are given" do
    config = @irc.instance_variable_get("@config")
    config[:server].should == "irc.freenode.net"
    config[:port].should == 6667
    config[:nick].should == "Circus-IRC"
    config[:username].should == "circus"
    config[:realname].should == "Using ruby with Circus IRC"
    config[:send_speed].should == 0.5
    config[:timeout].should == 15*60
    config[:eol].should == "\r\n"
    config[:debug].should == false
  end
  
  it "should not define a password if none is given" do
    @irc.instance_variable_get("@config")[:password].should be_nil
  end
  
  it "should update the config value when calling .param=" do
    @irc.instance_variable_get("@config")[:nick].should == "Circus-IRC"
    @irc.nick = "NewNick"
    @irc.instance_variable_get("@config")[:nick].should == "NewNick"
    
    @irc.instance_variable_get("@config")[:password].should be_nil
    @irc.password = "secret"
    @irc.instance_variable_get("@config")[:password].should == "secret"
    
    #if nick and password work, they should all work. now we just need to check that the methods exist
    %w(server port nick username realname send_speed timeout eol debug password).each do |config_value|
      fail "no method #{config_value}= defined" unless @irc.respond_to?("#{config_value}=".to_sym)
    end
  end
end
