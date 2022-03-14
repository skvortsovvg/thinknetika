# modules
require_relative 'information'
require_relative 'instance_counter'
require_relative 'validation'

# classes
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'carriage'
require_relative 'interface'

# ========= ТЕСТОВЫЕ ДАННЫЕ ================

train1 = CargoTrain.new("806-A1")
train1.produced = "Харьковский вагоностроительный завод"

cargo_wagon1 = CargoCarriage.new('1.1', 100)
cargo_wagon1.produced = "Харьковский вагоностроительный завод"
cargo_wagon2 = CargoCarriage.new('1.2', 100)
cargo_wagon2.produced = "Харьковский вагоностроительный завод"

train1.add_carriage(cargo_wagon1)
train1.add_carriage(cargo_wagon2)

train2 = PassengerTrain.new("533N1")
train2.produced = "Киевский электровагоноремонтный завод"

pass_wagon1 = PassengerCarriage.new("2.1", 15)
pass_wagon1.produced = "Киевский электровагоноремонтный завод"
pass_wagon2 = PassengerCarriage.new("2.2", 20)
pass_wagon2.produced = "Киевский электровагоноремонтный завод"

train2.add_carriage(pass_wagon1)
train2.add_carriage(pass_wagon2)

route = Route.new(Station.new("Ростов-на-Дону"), Station.new("Краснодар"))

route.add_station(Station.new("Каневская"))
route.add_station(Station.new("Тимашевск"))
route.add_station(Station.new("Староминская"))
route.add_station(Station.new("Батайск"))

train1.set_route(route)
train2.set_route(route)

Station.new("Москва")

pass_wagon1.book(7)
pass_wagon1.book(11)
pass_wagon1.book(1)

pass_wagon2.book(18)
pass_wagon2.book(13)
pass_wagon2.book(20)
pass_wagon2.book(15)
pass_wagon2.book(16)

cargo_wagon1.fill(10)
cargo_wagon1.fill(25)

cargo_wagon2.fill(5)
cargo_wagon2.fill(17)

# ==============================================
# main = Interface.new 
# main.start

Station.all.each do |station|
  puts "=========================="
  puts "Станция #{station.title}:" 
  puts "---------------------------" 
  station.each_train do |train| 
    puts "Поезд #{train.number} (тип: #{train.type}) #{"#{train.wagons.count} вагонов" if train.type == :passenger}"
      train.each_carriage do |carriage| 
        puts "- вагон #{carriage.number} (тип: #{carriage.type}), загрузка: #{carriage.reserved} из #{carriage.capacity}, свободно: #{carriage.free}"
      end
    puts "--------------------------"
  end
end