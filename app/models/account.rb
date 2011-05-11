class Account < ActiveRecord::Base
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :postal, :presence => true
  validates :email, :presence => true
end