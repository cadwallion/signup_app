require 'redis'

class Queue
  class << self
    attr_accessor :connection
    
    def connection
      @connection ||= Redis.new
    end
    
    def add_account(id)
      @connection.rpush("accounts", id)
    end
    
    def waiting(key_type)
      @connection.llen(key_type.to_s)
    end
  end
end