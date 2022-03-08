class Carriage

	attr_reader :number, :type

	def initialize(number)
		@number = number
    self.class.list << self
	end

  def self.list
    @@list ||= []
  end

  def self.print_list
    list.each_with_index { |v, i| puts "#{i}. #{v.number} (#{v.type})" }
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