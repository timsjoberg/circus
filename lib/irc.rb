module Circus
  class IRC
    
    DefaultOptions = {
      :port              => 6667
    }
    
    def initialize(server = nil, options = {})
      @events = {}
      
      options[:server] ||= server
      DefaultOptions.each do |k, v|
        options[k] ||= v
      end
      
      options[:username] ||= options[:nick]
      options[:realname] ||= "#{options[:nickname]} using Circus"
      
      @events[:disconnect] = options.delete(:on_disconnect)
      @events[:nick_error] = options.delete(:on_nick_error)
      
      @dispatch = Queue.new
      @dispatcher = Thread.new dispatcher
    end
    
    protected
    
    def dispatcher
      while job = @dispatch.shift
        begin
          job.shift.call(*job)
        rescue Exception => e
          exception(e)
        end
      end
    end
    
  end
end
