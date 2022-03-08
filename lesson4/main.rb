require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'carriage'

require 'io/console'

def menu

  puts
  puts "###################### МЕНЮ ####################"
  puts
  puts "1. Создать станцию"
  puts "2. Создать поезд"
  puts "3. Создать маршрут" 
  puts "4. Создать вагон"
  puts "5. Изменить маршрут"
  puts "6. Назначить маршрут поезду"
  puts "7. Добавить вагон к поезду"
  puts "8. Отцепить вагон от поезда"
  puts "9. Переместить поезд по маршруту"
  puts "10. Вывести список станций" 
  puts "11. Вывести список поездов на станции"
  puts 

  gets.chomp.to_i

end

def print_result(txt)
  system 'cls'
  puts "###################### РЕЗУЛЬТАТ ####################"
  puts
  puts txt
  puts
end

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

system 'cls'

loop do

  case menu
  when 1
    print "Создаем станцию. Введите название станции: "
    Station.new(gets.chomp)
    print_result("Создана новая станция <#{Station.list.last.title}>")

  when 2
 
    puts "Создаем поезд."
    print "Введите название поезда: "
    number = gets.chomp
    puts "Выберите тип поезда:"
    puts "1. Грузовой."
    puts "2. Пассажирский."

    case gets.chomp.to_i
    when 1
      CargoTrain.new(number)
    when 2
      PassengerTrain.new(number)
    else
      print_result("Ошибка: выбрано некорректное значение")
      next
    end
    
    print_result("Создан новый поезд <#{Train.list.last.number}>")

  when 3
    puts "Создаем маршрут." 
    Station.print_list
    puts 
    
    puts "Выберите начальную станцию: "
    s_station = Station.list[gets.chomp.to_i]
    
    print "Выберите конечную станцию: "
    f_station = Station.list[gets.chomp.to_i]
    
    Route.new(s_station, f_station)
    
    print_result("Создан новый маршрут <#{Route.list.last.title}>")

  when 4
    puts "Создаем вагон."
    puts "Введите номер вагона:"
    number = gets.chomp
    
    puts "Выберите тип вагона:"
    puts "1. Грузовой."
    puts "2. Пассажирский."

    case gets.chomp.to_i
    when 1
      CargoWagon.new(number)
    when 2
      PassengerWagon.new(number)
    else
      print_result("Ошибка: выбрано некорректное значение")
      next
    end

    print_result("Создан новый вагон <#{Carriage.list.last.number}>")

  when 5
    puts "Меняем маршрут." 
    puts "Выберите маршрут: "
    Route.print_list
    route = Route.list[gets.chomp.to_i]

    puts "Выберите операцию: "
    puts "1. Добавить станцию в маршрут."
    puts "2. Удалить станцию из маршрута."
    
    case gets.chomp.to_i
    when 1
      puts "Выберите станцию для добавления в маршрут: "
      Station.print_list
      route.add_station(Station.list[gets.chomp.to_i])
     
      print_result("Маршрут <#{route.title}> изменен>")

    when 2
      puts "Выберите станцию для удаления: "
      route.print_route_stations
      route.remove_station(route.stations[gets.chomp.to_i])
      
      print_result("Маршрут <#{route.title}> изменен>")
    
    else
      print_result("Ошибка: выбрано некорректное значение")
      next
    end

  when 6
    puts "Назначаем маршрут поезду." 
    Train.print_list
    puts "Выберите поезд: "
    train = Train.list[gets.chomp.to_i]
    Route.print_list
    print "Выберите маршрут: "
    route = Route.list[gets.chomp.to_i]
    train.set_route(route)
    
    print_result("Поезду <#{train.number}> назначен маршрут <#{route.title}>")

  when 7
    puts "Добавляем вагон поезду."
    Train.print_list
    
    puts "Выберите поезд:"
    train = Train.list[gets.chomp.to_i]

    puts "Выберите вагон:"
    Carriage.print_list
    train.add_carriage(Carriage.list[gets.chomp.to_i])
    
    print_result("Изменен состав поезда <#{train.number}>")

  when 8
    puts "Отцепляем вагон от поезда."
    Train.print_list
    
    puts "Выберите поезд:"
    train = Train.list[gets.chomp.to_i]

    puts "Выберите вагон:"
    train.print_wagons_list
    train.remove_carriage(train.wagons[gets.chomp.to_i])
    
    print_result("Изменен состав поезда <#{train.number}>")
  
  when 9
    puts "Поезд отправляется."
    Train.print_list
    
    puts "Выберите поезд:"
    train = Train.list[gets.chomp.to_i]
    
    puts "Выберите направление:"
    puts "1. Вперед."
    puts "2. Назад."
    
    case gets.chomp.to_i 
    when 1
      train.move_forward()
    when 2
      train.move_back()
    else
      print_result("Ошибка: выбрано некорректное значение")
      next
    end

    print_result("Поезд <#{train.number}> прибыл на станцию <#{train.current_station.title}>")

  when 10
    print_result("Список станций:")
    Station.print_list

  when 11
    puts "Выберите станцию: "
    Station.print_list
    station = Station.list[gets.chomp.to_i]
    
    print_result("Список поездов на стации <#{station.title}>")
    station.trains.each_with_index { |v, i| puts "#{i}. #{v.number} (#{v.type})" }

  when 0
    break
  
  else
    print_result("Ошибка: выбрано некорректное значение")
    next
  end

end