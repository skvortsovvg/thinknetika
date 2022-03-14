class Train
  attr_reader :number, :wagons, :type, :speed, :route, :current_station
  include InstanceCounter
  include Information
  include Validation

  NUM_FORMAT = /^\w{3}-?\w{2}$/i

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    validate!
    register_instance
    self.class.list << self
  end

  def each_carriage
    @wagons.each do |carriage|
      yield(carriage)  
    end
  end

  def self.list
    @@list ||= []
  end

  def self.find(number)
    res = list.select { |train| train if train.number == number }
    res.empty? ? nil : res.first
  end

  def speed_up
    @speed += 5
  end

  def speed_down
    @speed -= 5 if @speed > 0
  end

  def add_carriage(carriage)
    @wagons << carriage if !@wagons.member?(carriage) && carriage.type == self.type
  end

  def remove_carriage(carriage)
    @wagons.delete(carriage) if carriage.type == self.type
  end

  def set_route(route)
    @route = route
    if !@current_station.nil?
      @current_station.train_departs(self)
    end
    @current_station = route.stations.first
    @current_station.train_arrives(self)
  end

  def move_forward
    if !(@current_station == route.stations.last)
      @current_station.train_departs(self)
      @current_station = route.stations[route.stations.index(@current_station) + 1] if !(@current_station == route.stations.last)
      @current_station.train_arrives(self)
    end
  end

  def move_back
    if !(@current_station == route.stations.first)
      @current_station.train_departs(self)
      @current_station = route.stations[route.stations.index(@current_station) - 1] if !(@current_station == route.stations.first)
      @current_station.train_arrives(self)
    end
  end

  def next_station
    (@current_station == route.stations.last) ? nil : route.stations[route.stations.index(@current_station) + 1]
  end

  def previous_station
    (@current_station == route.stations.first) ? nil : route.stations[route.stations.index(@current_station) - 1]
  end

  protected

  def validate!
    raise ArgumentError, "Несоответствие типов: номер позеда должен иметь строковый тип" if number.class != String
    raise ArgumentError, "Некорректный номер: ожидается формат XXX-XX или XXXXX" if number !~ NUM_FORMAT
  end

end

class PassengerTrain < Train
  def initialize(number)
    super
    @type = :passenger
  end
end 

class CargoTrain < Train
  def initialize(number)
    super
    @type = :cargo
  end
end
