class VerificationWorker
  attr_reader :queue_key, :connection
  def initialize
    @queue_key = "accounts"
    @connection = Queue.connection
  end
  
  def start
    while true do
      if @connection.llen(@queue_key) == 0
        sleep 1
      else
        process_next
      end
    end
  end
  
  def process_next
    id = @connection.lpop(@queue_key)
    unless id.nil?
      account = Account.find(id)
      account.verify!
    end
  end
end