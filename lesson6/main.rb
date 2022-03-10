# modules
require_relative 'information'
require_relative 'instance_counter'

# classes
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'carriage'
require_relative 'interface'
require_relative 'test'

# ========= ТЕСТОВЫЕ ДАННЫЕ ================

train1 = CargoTrain.new("806Э")
train1.produced = "Харьковский вагоностроительный завод"

cargo_wagon = CargoWagon.new('1.1')
cargo_wagon.produced = "Харьковский вагоностроительный завод"

train2 = PassengerTrain.new("533М")
train1.produced = "Киевский электровагоноремонтный завод"

pass_wagon = PassengerWagon.new('2.1')
pass_wagon.produced = "Киевский электровагоноремонтный завод"

route = Route.new(Station.new("Ростов-на-Дону"), Station.new("Краснодар"))

route.add_station(Station.new("Каневская"))
route.add_station(Station.new("Тимашевск"))
route.add_station(Station.new("Староминская"))
route.add_station(Station.new("Батайск"))

Station.new("Москва")
# ==============================================

# puts train1.produced
# puts cargo_wagon.produced

# puts Station.all.inspect

# puts Train.find('111').inspect
# puts Train.find('806Э').inspect

puts Train.instances
puts CargoTrain.instances
puts PassengerTrain.instances
puts Station.instances
puts Route.instances

puts Train.instance_variables.inspect # => ["@a"]
puts Train.class_variables.inspect

puts CargoTrain.instance_variables.inspect # => ["@a"]
puts CargoTrain.class_variables.inspect

# Route.get_b
# Main = Interface.new 
# Main.start

