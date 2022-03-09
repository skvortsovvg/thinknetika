# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_reader :title, :stations

  def initialize(start, finish)
    @stations = [start, finish]
    @title = create_title
    self.class.list << self
  end

  def self.list
    @@list ||= []
  end

  def add_station(new_station, previous_station = nil)
  	return if previous_station == @stations.first 
  	index = @stations.index(previous_station)
	index = -2 if index == nil
 	@stations.insert(index, new_station)
  end

  def remove_station(station)
    @stations.delete(station) if !(station == @stations.first || station == @stations.last)
  end

  private

  def create_title
    "#{@stations.first.title} - #{@stations.last.title}"
  end

end
