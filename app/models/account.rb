class Account < ActiveRecord::Base
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :postal, :presence => true
  validates :email, :presence => true
  
  attr_accessor :phone1, :phone2, :phone3
  
  STATES = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", 
              "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
              "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
              "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", 
              "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
  
  def address
    if self.address2.nil?
      address1
    else
      "#{self.address1}, #{self.address2}"
    end
  end
  
  def formatted_phone
    if self.phone =~ /^\d{10}$/
      "#{self.phone[0,3]}-#{self.phone[3,3]}-#{self.phone[6,4]}"
    elsif self.phone =~ /^\d{11}$/
      "#{self.phone[0,1]}-#{self.phone[1,3]}-#{self.phone[4,3]}-#{self.phone[7,4]}"
    end
  end
end