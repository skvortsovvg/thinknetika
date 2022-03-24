class Station
  attr_reader :title, :trains

  include InstanceCounter
  include Validation

  validate :title, :presence
  validate :title, :type, String

  def initialize(title)
    @title  = title
    @trains = []
    validate!
    register_instance
    self.class.all << self
  end

  def each_train(&block)
    @trains.each(&block)
  end

  def self.all
    @@all ||= []
  end

  def train_arrives(train)
    @trains << train
  end

  def train_departs(train)
    @trains.delete(train)
  end

  def trains_by_type
    cargo = 0
    pass  = 0

    @trains.each do |tr|
      cargo += 1 if tr.type == :cargo
      pass += 1 if tr.type == :passanger
    end

    { cagro: cargo, passanger: pass }
  end

end
