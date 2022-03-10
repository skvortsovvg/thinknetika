# Класс Train (Поезд):
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route). 
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  attr_reader :number, :wagons, :type, :speed, :route, :current_station
  include InstanceCounter
  include Information

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    register_instance
    self.class.list << self
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
    if !(@current_station == route.stations.last) 
      puts "Следующая станция: #{route.stations[route.stations.index(@current_station) + 1].title}"
    else
      puts "Это конечная станция маршрута!"
    end
  end

  def previous_station
    if !(@current_station == route.stations.first)
      puts "Предыдущая станция: #{route.stations[route.stations.index(@current_station) - 1].title}"
    else
      puts "Это первая станция маршрута!"
    end
  end
end

class PassengerTrain < Train
  # @instances = 0
  def initialize(number)
    super
    @type = :passenger
  end
end 

class CargoTrain < Train
  # @instances = 0
  def initialize(number)
    super
    @type = :cargo
  end
end
