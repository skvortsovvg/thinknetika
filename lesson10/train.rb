class Train

  include InstanceCounter
  include Information
  include Validation
  extend Accessors

  attr_reader :number, :wagons, :type, :speed, :route, :current_station
  attr_accessor_with_history :depo, :owner
  strong_attr_accessor :inspection_date, :repair_date

  NUM_FORMAT = /^\w{3}-?\w{2}$/i

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    validate!
    register_instance
    self.class.list << self
  end

  # def method_missing(name, *args)
  #   self.class.attr_accessor_with_history(name, *args)
  # end

  def each_carriage(&block)
    @wagons.each(&block)
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
    @speed -= 5 if @speed.positive?
  end

  def add_carriage(carriage)
    @wagons << carriage if !@wagons.member?(carriage) && carriage.type == type
  end

  def remove_carriage(carriage)
    @wagons.delete(carriage) if carriage.type == type
  end

  def set_route(route)
    @route = route
    @current_station.train_departs(self) unless @current_station.nil?
    @current_station = route.stations.first
    @current_station.train_arrives(self)
  end

  def move_forward
    return if @current_station == route.stations.last

    @current_station.train_departs(self)
    unless @current_station == route.stations.last
      @current_station = route.stations[route.stations.index(@current_station) + 1]
    end
    @current_station.train_arrives(self)
  end

  def move_back
    return if @current_station == route.stations.last

    @current_station.train_departs(self)
    unless @current_station == route.stations.first
      @current_station = route.stations[route.stations.index(@current_station) - 1]
    end
    @current_station.train_arrives(self)
  end

  def next_station
    @current_station == route.stations.last ? nil : route.stations[route.stations.index(@current_station) + 1]
  end

  def previous_station
    @current_station == route.stations.first ? nil : route.stations[route.stations.index(@current_station) - 1]
  end

  protected

  def validate!
    validate :number, :presence
    validate :number, :type, String
    validate :number, :format, NUM_FORMAT
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
