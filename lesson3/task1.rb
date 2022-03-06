# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station

  # Может возвращать список всех поездов на станции, находящиеся в текущий момент
  attr_reader :name, :trains

  # Имеет название, которое указывается при ее создании
  def initialize(name)
    @name = name
    @trains = []
  end

  # Может принимать поезда (по одному за раз)
  def train_arrives(train)
    @trains << train
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def train_departs(train)
    @trains.delete(train)
  end

  # Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def get_trains_by_type
  	cargo = 0; pass = 0;
  	@trains.each do |tr| 
  		cargo += 1 if tr.type == :cargo
  		pass += 1 if tr.type == :passanger
  	end
  	return { cagro: cargo, passanger: pass } 
  end  

end

# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route

  attr_reader :stations

  # Имеет начальную и конечную станцию, а также список промежуточных станций. 
  # Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
  def initialize(start, finish)
    @stations = [start, finish]
  end

  # Может добавлять промежуточную станцию в список
  def add_station(new_station, previous_station = nil)
  	return if previous_station == @stations.first 
  	ind = @stations.index(previous_station)
	ind = -2 if ind == nil
 	@stations.insert(ind, new_station)
  end

  # Может удалять промежуточную станцию из списка
  def remove_station(station)
    @stations.delete(station) if !(station == @stations.first || station == @stations.last)
  end
  
end

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
  
  # Может возвращать текущую скорость
  # Может возвращать количество вагонов
  attr_reader :number, :size, :type, :speed, :route

  # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти
  # данные указываются при создании экземпляра класса
  def initialize(number, type, size)
    @number = number
    @type = type
    @size = size
    @speed = 0
  end

  # Может набирать скорость
  def speed_up
    @speed += 5
  end

  # Может тормозить (сбрасывать скорость до нуля)
  def speed_down
    @speed -= 5 if @speed > 0
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  # Прицепка/отцепка вагонов может осуществляться только если поезд не движется.    
  def increase
    @size += 1 if @speed == 0
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  # Прицепка/отцепка вагонов может осуществляться только если поезд не движется.    
  def decraise
    @size -= 1 if @speed == 0 && @size > 0
  end

  # Может принимать маршрут следования (объект класса Route). 
  # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  def set_route(route)
    @route = route
    @current_station = route.stations.first
  end

  # Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def move_forward
    @current_station = route.stations[route.stations.index(@current_station) + 1] if !(@current_station == route.stations.last)
  end

  # Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def move_back
    @current_station = route.stations[route.stations.index(@current_station) - 1] if !(@current_station == route.stations.first)
  end

  def current_station
    puts "Текущая станция: #{@current_station.name}"
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def next_station
    if !(@current_station == route.stations.last) 
      puts "Следующая станция: #{route.stations[route.stations.index(@current_station) + 1].name}"
    else
      puts "Это конечная станция маршрута!"
    end
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def previous_station
    if !(@current_station == route.stations.first)
      puts "Предыдущая станция: #{route.stations[route.stations.index(@current_station) - 1].name}"
    else
      puts "Это первая станция маршрута!"
    end
  end
end

###################### MAIN ####################

start_st = Station.new("Краснодар")
finish_st = Station.new("Ростов-на-Дону")

route = Route.new(start_st, finish_st)

train = Train.new("806Э", :passanger, 5)
train2 = Train.new("533М", :passanger, 5)

finish_st.train_arrives(train)
finish_st.train_arrives(train2)

puts finish_st.trains
puts finish_st.get_trains_by_type

finish_st.train_departs(train2)

puts finish_st.trains
puts finish_st.get_trains_by_type

tim_st = Station.new("Тимашевск")
msk_st = Station.new("Москва")

route.add_station(Station.new("Каневская"))
route.add_station(tim_st)
route.add_station(Station.new("Староминская"))
route.add_station(Station.new("Батайск"))
route.get_route

route.add_station(msk_st, finish_st)
route.get_route

route.remove_station(tim_st)
route.remove_station(msk_st)
route.get_route

train.set_route(route)

5.times { train.speed_up }
train.current_station
puts train.speed

6.times { train.speed_down }
puts train.speed

3.times { train.move_forward }
train.current_station

train.move_back
train.current_station

train.next_station
train.previous_station

puts train.size
3.times { train.increase }
puts train.size

4.times { train.decraise }
puts train.size
