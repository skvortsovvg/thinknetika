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
    self.class.validations.each do |v|
      $VALIDATIONS[v[:validation_type]].call(v[:var_name], eval("@#{v[:var_name]}"), v[:option]) 
    end
    raise "Количество мест указано некорректно!" unless (1..100).include?(@capacity)
  end
end

class PassengerCarriage < Carriage
  
  validate :number, :presence
  validate :number, :type, String
  validate :capacity, :type, Integer
  
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
