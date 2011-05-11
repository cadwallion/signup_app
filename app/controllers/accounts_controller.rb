class AccountsController < ApplicationController  
  def index
    @accounts = Account.all
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @accounts }
    end
  end
  
  def new
    @account = Account.new
  end
  
  def edit
    @account = Account.find(params[:id])
  end
  
  def update
    @account = Account.find(params[:id])
    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def create
    @account = Account.new(params[:account])
    
    respond_to do |format|
      if @account.save
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @account = Account.new(params[:id])
    @account.destroy
    
    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml { head :ok }
    end
  end
end
