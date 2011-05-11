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

describe AccountsController do
  describe "GET index" do
    it "should assign @accounts" do
      account = Account.create(required_attributes)
      get :index
      assigns(:accounts).should eq([account])
    end
  end
  
  describe "GET new" do
    it "should assign new instance of Account" do
      get :new
      assigns(:account).should be_instance_of(Account)
    end
  end
  
  describe "GET edit" do
    it "should assign @account to Account based on params[:id]" do
      account = Account.create(required_attributes)
      get :edit, :id => account.id
      assigns(:account).should == account
    end
  end
  
  describe "POST create" do
    context "with valid attributes" do
      it "should create a new Account object" do
        post :create, :account => required_attributes
        response.should redirect_to(account_path(assigns(:account)))
      end   
    end
    context "with invalid attributes" do
      it "should render new template" do
        post :create, :account => required_attributes.except(:first_name)
        assigns(:account).should_not be_valid
        response.should render_template(:action => 'new')
      end
    end   
  end
  
  describe "PUT update" do
    context "with valid attributes" do
      it "should update the Account object" do
        account = Account.create(required_attributes)
        put :update, :id => account.id, :account => required_attributes.merge(:first_name => "Untested")
        Account.find(account.id).should == assigns(:account)
      end
    end
    context "with invalid attributes" do
      it "should render the edit template" do
        account = Account.create(required_attributes)
        put :update, :id => account.id, :account => { :first_name => nil }
        assigns(:account).should_not be_valid
        response.should render_template(:action => 'edit')
      end
    end
  end
  
  describe "DELETE destroy" do
    it "should remove the Account object" do
      account = Account.create(required_attributes)
      delete :destroy, :id => account.id
      assigns(:account).should be_destroyed
      response.should redirect_to(accounts_path)
    end
  end
end
