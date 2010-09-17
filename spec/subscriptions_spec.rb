require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Circus::EventManager, "#subscribe" do
  before(:each) do
    @event_manager = Circus::EventManager.new
  end
  
  it "should add the subscription" do
    test = 0
    
    id = @event_manager.subscribe(:ENDOFMOTD) do
      test = 1
    end
    
    @event_manager.event(:ENDOFMOTD, "End of /MOTD command.")
    test.should == 1
  end
  
end

describe Circus::EventManager, "#unsubscribe" do
  before(:each) do
    @event_manager = Circus::EventManager.new
  end
  
  it "should return false if subscription does not exist" do
    @event_manager.unsubscribe("a").should == false
  end
  
  it "should return true if the subscription exists" do
    id = @event_manager.subscribe(:ENDOFMOTD) do
      puts "something"
    end
    
    @event_manager.unsubscribe(id).should == true
  end
  
  it "should remove the subscription" do
    test = 0
    
    id = @event_manager.subscribe(:ENDOFMOTD) do
      test = 1
    end
    
    @event_manager.unsubscribe(id)
    @event_manager.event(:ENDOFMOTD, "End of /MOTD command.")
    test.should == 0
  end
  
end
