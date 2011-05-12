require 'redis'

class Queue
  class << self
    #attr_accessor :connection
  
    def connection
      @connection ||= Redis.new
    end
    
    def add_account(id)
      @connection.rpush("accounts", id)
    end
    
    def pending_verification
      @connection.llen("accounts")
    end
  end
end