module Information
  attr_accessor :produced

  def valid?
    validate!
  rescue
    false
  end

end	
