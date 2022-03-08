# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station
  attr_reader :title, :trains

  def initialize(title)
    @title = title
    @trains = []
    self.class.list << self
  end

  def self.list
    @@list ||= []
  end

  def train_arrives(train)
    @trains << train
  end

  def train_departs(train)
    @trains.delete(train)
  end

  def get_trains_by_type
  	
    cargo = 0; pass = 0;
  	
    @trains.each do |tr| 
  		cargo += 1 if tr.type == :cargo
  		pass += 1 if tr.type == :passanger
  	end
  	
    { cagro: cargo, passanger: pass } 
  
  end  

end
