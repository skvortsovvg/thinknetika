class Carriage
  attr_reader :number, :type, :capacity
  include Information
  include Validation
  
  def initialize(number, capacity)
    @number   = number
    @capacity = capacity
    validate!
    self.class.list << self
  end

  def self.list
    @@list ||= []
  end

private

  def validate!
    raise "Несоответствие типов: номер вагона должен быть текстовым" if @number.class != String
    raise "Несоответствие типов: вместимость должна быть числовой" if @capacity.class != Integer
    raise "Не указан номер вагона!" if @number.empty?
    raise "Количество мест указано некорректно!" if !(1..100).include?(@capacity)
  end

end

class PassengerCarriage < Carriage
  def initialize(number, capacity)
    super
    @seats  = Hash[(1..capacity).zip(Array.new(capacity, false))]
    @type   = :passenger
  end

  def book(seat_num)
    @seats[seat_num] = true if seat_num <= @capacity
  end

  def reserved
    @seats.select { |key, value| value }.keys.size
  end

  def free
    @seats.select { |key, value| !value }.keys.size
  end
end 

class CargoCarriage < Carriage
  def initialize(number, capacity)
    super
    @type = :cargo
    @load = 0
  end

  def fill(value)
    @load += value if @load + value <= @capacity
  end

  def reserved
    @load
  end

  def free
    @capacity-@load
  end
end
