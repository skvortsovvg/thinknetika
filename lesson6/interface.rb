class Interface
  def start
    loop do 
      case menu
      when 0
        break
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        create_carriage
      when 5
        edit_route
      when 6
        assign_route
      when 7
        add_carriage
      when 8
        remove_carriage
      when 9
        run_train
      when 10
        print_result("Список станций:")
        print_stations
      when 11
        print_station_trains
      else
        print_result("Ошибка: выбрано некорректное значение")
        next
      end
    end
  end

private

  # Сами по себе эти методы не имеют смысла, поэтому их вызов из вне нужно запретить  

  def create_station
    print "Создаем станцию. Введите название станции: "
    Station.new(gets.chomp)
    print_result("Создана новая станция <#{Station.all.last.title}>")
  end

  def create_train
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
      return
    end
    
    print_result("Создан новый поезд <#{Train.list.last.number}>")
  end

  def create_route
    puts "Создаем маршрут." 
    print_stations
    puts 
      
    puts "Выберите начальную станцию: "
    s_station = Station.all[gets.chomp.to_i]
      
    print "Выберите конечную станцию: "
    f_station = Station.all[gets.chomp.to_i]
      
    Route.new(s_station, f_station)
      
    print_result("Создан новый маршрут <#{Route.list.last.title}>")
  end    

  def create_carriage
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
      return
    end

    print_result("Создан новый вагон <#{Carriage.list.last.number}>")
  end

  def edit_route
    puts "Меняем маршрут." 
    puts "Выберите маршрут: "
    print_routes
    route = Route.list[gets.chomp.to_i]

    puts "Выберите операцию: "
    puts "1. Добавить станцию в маршрут."
    puts "2. Удалить станцию из маршрута."
    
    case gets.chomp.to_i
    when 1
      puts "Выберите станцию для добавления в маршрут: "
      print_stations
      route.add_station(Station.all[gets.chomp.to_i])
     
      print_result("Маршрут <#{route.title}> изменен>")

    when 2
      puts "Выберите станцию для удаления: "
      print_route_stations(route)
      route.remove_station(route.stations[gets.chomp.to_i])
      
      print_result("Маршрут <#{route.title}> изменен>")
    
    else
      print_result("Ошибка: выбрано некорректное значение")
      return
    end
  end

  def assign_route
    puts "Назначаем маршрут поезду." 
    print_trains
    puts "Выберите поезд: "
    train = Train.list[gets.chomp.to_i]
    print_routes
    print "Выберите маршрут: "
    route = Route.list[gets.chomp.to_i]
    train.set_route(route)
    
    print_result("Поезду <#{train.number}> назначен маршрут <#{route.title}>")
  end

  def add_carriage
    puts "Добавляем вагон поезду."
    print_trains
    puts "Выберите поезд:"
    train = Train.list[gets.chomp.to_i]

    puts "Выберите вагон:"
    print_wagons
    train.add_carriage(Carriage.list[gets.chomp.to_i])
    
    print_result("Изменен состав поезда <#{train.number}>")
  end

  def remove_carriage
    puts "Отцепляем вагон от поезда."
    print_trains 
    puts "Выберите поезд:"
    train = Train.list[gets.chomp.to_i]

    puts "Выберите вагон:"
    print_train_wagons(train)
    train.remove_carriage(train.wagons[gets.chomp.to_i])
    
    print_result("Изменен состав поезда <#{train.number}>")
  end

  def run_train
    puts "Поезд отправляется."
    print_trains
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
      return
    end

    print_result("Поезд <#{train.number}> прибыл на станцию <#{train.current_station.title}>")
  end

  def print_stations
    Station.all.each_with_index { |v, i| puts "#{i}. #{v.title}" }
  end

  def print_routes
    Route.list.each_with_index { |v, i| puts "#{i}. #{v.title}" }
  end

  def print_wagons
    Carriage.list.each_with_index { |v, i| puts "#{i}. #{v.number} (#{v.type})" }
  end

  def print_trains
    Train.list.each_with_index { |v, i| puts "#{i}. #{v.number}, #{v.type}" }
  end

  def print_route_stations(route)
    route.stations.each_with_index { |v, i| puts "#{i}. #{v.title}" }
  end
  
  def print_train_wagons(train)
    train.wagons.each_with_index { |v, i| puts "#{i}. #{v.number}" }
  end

  def print_station_trains
    puts "Выберите станцию: "
    print_stations
    station = Station.all[gets.chomp.to_i]
    
    print_result("Список поездов на стации <#{station.title}>")
    station.trains.each_with_index { |v, i| puts "#{i}. #{v.number} (#{v.type})" }
  end
  
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

end
