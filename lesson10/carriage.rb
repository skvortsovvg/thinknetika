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

end

class PassengerCarriage < Carriage
  
  validate :number, :presence
  validate :number, :type, String
  validate :capacity, :type, Integer
  validate :capacity, :capacity, (1..100)
  
  def initialize(number, capacity)
    super
    @seats  = Hash[(1..capacity).zip(Array.new(capacity, false))]
    @type   = :passenger
  end

  def book(seat_num)
    @seats[seat_num] = true if seat_num <= @capacity
  end

  def reserved
    @seats.select { |_key, value| value }.keys.size
  end

  def free
    @seats.reject { |_key, value| value }.keys.size
  end
end

class CargoCarriage < Carriage
  
  validate :number, :presence
  validate :number, :type, String
  validate :capacity, :type, Integer
  validate :capacity, :capacity, (1..500)

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
    @capacity - @load
  end
end
