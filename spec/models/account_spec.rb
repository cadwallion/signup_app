require 'spec_helper'

describe Account do
  include AccountHelper
  context "validations" do
    before(:each) do
      @account = Account.new
    end
    
    it "should require first_name" do
      presence_of_column @account, :first_name
    end
    
    it "should require last_name" do
      presence_of_column @account, :last_name
    end
    
    it "should require address1" do
      presence_of_column @account, :address1
    end
    
    it "should require city" do
      presence_of_column @account, :city
    end
    
    it "should require state" do
      presence_of_column @account, :state
    end
    
    it "should require postal" do
      presence_of_column @account, :postal
    end
    
    it "should require email" do
      presence_of_column @account, :email
    end
  end

  describe "#address" do
    before(:each) do
      @account = Account.new(required_attributes)
    end
    it "should return only address1 if address2 is not specified" do
      @account.address.should == @account.address1
    end
    
    it "should return comma-separated address1/address if address2 is specified" do
      @account.address2 = "Apartment 2B"
      @account.address.should == "#{@account.address1}, #{@account.address2}"
    end
  end
  
  describe "#formatted_phone" do
    it "should format phone to xxx-xxx-xxxx display if phone is 10-digits" do
      @account = Account.new(:phone => "1234567890")
      @account.formatted_phone.should == "123-456-7890"
    end
    
    it "should format phone to x-xxx-xxx-xxxx display if phone is 11-digits" do
      #@account = Account.new(:phone => "11234567890")
      @account = Account.new(:phone => "11234567890")
      @account.formatted_phone.should == "1-123-456-7890"
    end
  end
  
  describe "#sanitize_phone" do
    it "should remove formatting characters" do
      @account = Account.new(:phone => "(123) 456-7890")
      @account.sanitize_phone
      @account.phone.should == "1234567890"
    end
  end
  
  describe "#verify!" do
    it "sets verified to true" do
      @account = Account.create(required_attributes)
      @account.verify!
      @account.verified.should be_true
    end
    
    it "returns false if attempting to verify an unsaved record" do
      @account = Account.new
      @account.verify!.should be_false
    end
  end
  
  describe "#search" do
    before(:each) do
      Account.create!(required_attributes)
      Account.create!(required_attributes.merge(:first_name => "Jon"))
    end
    
    it "returns no rows if the search type is not valid" do
      accounts = Account.search(:type => "foo", :term => "Jon")
      accounts.should be_empty
    end
    
    it "returns rows based on valid search type" do
      accounts = Account.search(:type => "first_name", :term => "Jon")
      accounts.size.should == 1
    end
  end
end