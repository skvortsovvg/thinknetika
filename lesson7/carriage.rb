class Carriage
  attr_reader :number, :type
  include Information
  include Validation
  
  def initialize(number)
    @number = number
    validate!
    self.class.list << self
  end

  def self.list
    @@list ||= []
  end

private

  def validate!
    raise "Несоответствие типов: номер вагона должен быть текстовым" if @number.class != String
    raise "Не указан номер вагона!" if @number.empty?
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
