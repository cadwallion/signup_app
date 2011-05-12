require 'spec_helper'

describe Queue do
  include AccountHelper
  
  before(:each) do
    Queue.connection.del("accounts")
  end
  
  describe "#connection" do
    it "returns a Redis handler" do
      Queue.connection.should be_kind_of(Redis)
    end
  end
  
  describe "#add_account" do
    it "push id to the account list" do
      a = Account.create(required_attributes)
      count = Queue.pending_verification
      Queue.add_account(a.id).should > 0
    end
  end
  
  describe "#waiting" do
    it "returns the count of the queue type" do
      a = Account.create(required_attributes)
      Queue.add_account(a.id)
      Queue.pending_verification.should == 1
    end
    
    it "returns 0 for a non-existent queue" do
      Queue.pending_verification.should == 0
    end
  end
end