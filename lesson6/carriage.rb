class Carriage
  attr_reader :number, :type
  include Information
  
	def initialize(number)
		@number = number
    self.class.list << self
	end

  def self.list
    @@list ||= []
  end

end

class PassengerWagon < Carriage
  def initialize(number)
    super
    @type = :passenger
  end
end 

class CargoWagon < Carriage
  def initialize(number)
    super
    @type = :cargo
  end
end
