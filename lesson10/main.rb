# modules
require_relative 'information'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

# classes
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'carriage'
require_relative 'interface'

require 'Date'

# ========= ТЕСТОВЫЕ ДАННЫЕ ================

train1 = CargoTrain.new("806-A1")
train1.produced = "Харьковский вагоностроительный завод"

cargo_wagon1 = CargoCarriage.new("2.2", 100)
cargo_wagon1.produced = "Харьковский вагоностроительный завод"
cargo_wagon2 = CargoCarriage.new('1.2', 100)
cargo_wagon2.produced = "Харьковский вагоностроительный завод"

train1.add_carriage(cargo_wagon1)
train1.add_carriage(cargo_wagon2)

train2 = PassengerTrain.new("333-33")
train2.produced = "Киевский электровагоноремонтный завод"

pass_wagon1 = PassengerCarriage.new("2.1", 1)
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

train1.owner = "Укрзализныця"
train1.owner = "Крымская железная дорога"
train1.owner = "РЖД"

train1.depo = "Симферополь"
train1.depo = "Москва"

puts train1.owner_history.inspect
puts train1.depo_history.inspect

train1.repair_date = Date.new(2001, 2, 3), Date
puts train1.repair_date.inspect

train1.repair_date = "20 марта" #Ошибка
