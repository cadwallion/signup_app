require 'spec_helper'

describe VerificationWorker do
  include AccountHelper
  describe "#initialize" do
    it "creates a connection to the Queue connection" do
      v = VerificationWorker.new
      v.connection.should == Queue.connection
    end
    
    it "sets the queue_key to accounts" do
      v = VerificationWorker.new
      v.queue_key.should == "accounts"
    end
  end
  
  describe "#process_next" do
    before(:each) do
      @account = Account.create(required_attributes)
      Queue.add_account(@account.id)
      @worker = VerificationWorker.new
    end
    it "pulls the next account from the queue" do
      start_count = Queue.pending_verification
      @worker.process_next
      Queue.pending_verification.should == start_count - 1
    end
    
    it "runs verify! on the account it pulls" do
      @worker.process_next
      @account = Account.find(@account.id)
      @account.verified.should be_true
    end
  end
end