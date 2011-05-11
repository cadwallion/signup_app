require 'spec_helper'

def required_attributes
  {
    :first_name => "Test",
    :last_name => "Person",
    :address1 => "123 Test St",
    :city => "Testing",
    :state => "IL",
    :postal => "12345",
    :email => "foo@bar.com"
  }
end

def presence_of_column(record, column)
  record.attributes = required_attributes.except(column)
  record.should_not be_valid
  record.send("#{column}=", required_attributes[column])
  record.should be_valid
end

describe Account do
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
end