module AccountHelper
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
end