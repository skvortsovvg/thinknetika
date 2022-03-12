class Route
  attr_reader :title, :stations
  include InstanceCounter
  include Validation
 
  def initialize(start, finish)
    @stations = [start, finish]
    validate!
    @title = create_title
    register_instance
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

  def validate!
    @stations.each_with_index do |v, i|
      raise "Несоответствие типов: параметр #{i+1} (ожидается тип Station)" if v.class != Station
    end
  end

end
