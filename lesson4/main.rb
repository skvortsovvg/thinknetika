require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'carriage'
require_relative 'interface'

# ========= ТЕСТОВЫЕ ДАННЫЕ ================

train1 = CargoTrain.new("806Э")
train2 = PassengerTrain.new("533М")

train1.add_carriage(CargoWagon.new('1.1'))
train1.add_carriage(CargoWagon.new('1.2'))

train2.add_carriage(PassengerWagon.new('2.1'))
train2.add_carriage(PassengerWagon.new('2.2'))

route = Route.new(Station.new("Ростов-на-Дону"), Station.new("Краснодар"))

route.add_station(Station.new("Каневская"))
route.add_station(Station.new("Тимашевск"))
route.add_station(Station.new("Староминская"))
route.add_station(Station.new("Батайск"))

Station.new("Москва")

# ==============================================

Main = Interface.new 
Main.start