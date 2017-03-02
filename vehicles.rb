# -----------------------------------------------------------------
# 3.  Объект: Транспортное средство
#      Свойства:   Вид транспортного средства   
#                  Скорость
#      Состояние:  Стоит на месте
#                  Двигается
#                  Исправно
#                  Неисправно
#                  Дорога закончилась
#      Методы:     Показать скорость
#                  Задать(изменить) скорость
#                  Показать текущее состояние движения
#                  Остановить
#                  Начать движение
#                  Показать текущее техническое состояние
#                  Сломать
#                  Отремонтировать
#                  Показать текущее расположение на дороге
# добавление транспортного средства
def add_veh
  # проверка статуса игры
  if @flag_game == true 
    puts "Message of game"
    puts "You can't add traffic ligth, \
        \nbecause the traffic is already activated!"
    return
  end
  # проверка наличия дорог: этот блок понадобится для развития игры,
  # связанным с использованием нескольких дорог
=begin
  if @route_list.size == 0
    puts "----------------- \
        \nRoute not defined \
        \n-----------------"
    return  
  else
    i = 0
    puts "--------------- \
        \nList of router \
        \n---------------"
    @route_list.each{|item| arr = item; i += 1; 
    puts " #{i}. #{arr.route_length} km \
        \n---------------"
    }

    print "Enter id of route (from 1 to #{@route_list.size}): "
    input = gets.chomp.to_i    
  end

  if input < 1 || input > @route_list.size
    puts "Invalid value '#{input}'"
    return false
  end  
  id_route = input
=end
  id_route = 1
  while true    
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
      puts "Query of game"
      print "Add Vehicle? (Y/N): "
      input = gets.chomp  # проверка запроса на продолжение создания светофора
    end
    unless input  == "Y" or input  == "y"
      return
    end    
    puts "Query of game"
    print "Enter type of vehicle: "
    input = gets.chomp
    if input == ""
      puts "Query of game"
      puts "You not entered type!"      
    else
      type = input
      puts "Query of game"
      print "Enter speed of vehicle: "
      input = gets.chomp
      input = input.to_i
      if input <= 0 || input > 200
        puts "Message of game"
        puts "Invalid value '#{input}'"        
      else
        speed = input
        # создание нового экземпляра транспортного средства    
        @vehicle_list.push(instance_eval "@#{type} = Vehicle.new(type, speed)")
        @vehicle_list[@vehicle_list.size - 1].id_route = id_route
        puts "Info of game"
        puts "New vehicle '#{type}'. Speed: '#{speed}' km"
      end 
      
    end    
  end
end

# Изменить параметры транспортного средства
def change_veh
  if @vehicle_list.size == 0
    puts "Message of game"
    puts "Vehicles don't exist!"
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
      puts "Query of game"
      print "Add vehicle? (Y/N): "
      input = gets.chomp 
    end
    unless input  == "Y" or input  == "y"
      return
    end 
    add_veh
  end  
  if @vehicle_list.size == 0
    return
  end

  puts "List of Vehicles \
      \n------------------------------------------------- \
      \n| Id | Type  | Speed\t| Move  | Tech  | Loc\t| \
      \n-------------------------------------------------"
  i = 0
  @vehicle_list.each{|item| arr = item; i += 1; 
  print "| #{i}. "
  instance_eval "@#{arr.type}.show_veh"
  }
  puts "Query of game"
  print "Enter id of vehicle (from 1 to #{@vehicle_list.size}): "
  input = gets.chomp  
  input = input.to_i  
  if input < 1 || input > @vehicle_list.size
    puts "Message of game"
    puts "Invalid value '#{input}'"
    return false
  end

  while true
    puts "Control options^ \
       \n'S' - speed \
       \n'M' - state of motion \
       \n'T' - technical state \
       \n'Q' - quit"
    print "Enter id of option:"
    symb = gets.chomp    
    case symb
      when "s" || "S"
        @vehicle_list[input - 1].change_speed
      when "m" || "M"
        @vehicle_list[input - 1].change_move
      when "t" || "T"
        @vehicle_list[input - 1].change_tech
      when "q" || "Q"
        return
    end
  end
end

# Показать транспортные средства и их состояние
def show_vehs
  if @vehicle_list.size == 0
    puts "Message of game"
    puts "Vehicles don't exist!"    
    return
  end
  puts "Current state of vehicles on the route \
      \n----------------------------------------- \
      \n| Type  | Speed\t| Move  | Tech  | Loc\t| \
      \n-----------------------------------------"
  @vehicle_list.each{|item| arr = item
    instance_eval "@#{arr.type}.show_veh"
  }
  puts "-----------------------------------------"
end
# Описание класса Этранспортные средства
class Vehicle
  def initialize(type, speed = 20)
    @type = type
    @speed = speed
    @move_state = "stand" # stand | move
    @tech_state = true    # true (исправно) | false (неисправно) / nill
    @last_loc = 0         # последнее расположение на маршруте
    @id_route = 0         # номер маршрута     
  end

  attr_accessor :speed, :move_state, :tech_state, :type, :id_route, :last_loc
 
# Метод изменения скорости транспортного средства  
  def change_speed    
    puts "Query of game"
    puts "Type: #{@type}   Current speed: #{@speed}"
    print "Enter new speed of vehicle (from 1 to 200): "    
    input = gets.chomp
    input = input.to_i
    if input <= 0 || input > 200
      puts "Message of game"
      puts "Invalid value '#{input}'"
      return
    else
      @speed = input
      puts "Info of game"
      puts "Type: #{@type}   New speed: #{@speed}"
    end
  end

# Метод изменения статуса движения транспортного средства  
  def change_move    
    puts "Query of game"
    puts "Type: #{@type}   Current state: #{@move_state}"
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
      print "To change the state? (Y/N): "
      input = gets.chomp 
    end
    if input  == "Y" or input  == "y"      
      @move_state == "stand" ? @move_state = "moves" : @move_state = "stand"
      puts "Ihfo of game"
      puts "Type: #{@type}   New state: #{@move_state}" 
    end
  end

# Метод изменения технического состояния транспортного средства  
  def change_tech    
    puts "Query of game"
    puts "Type: #{@type}   Current state: #{@tech_state}"
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
      print "To change the state? (Y/N): "
      input = gets.chomp 
    end
    if input  == "Y" or input  == "y"      
      @tech_state == true ? @tech_state = false : @tech_state = true
      puts "Info of game"
      puts "Type: #{@type}   New state: #{@tech_state}" 
    end
  end

  def show_veh
    puts "| #{@type}\t|  #{@speed}\t| #{@move_state} | #{@tech_state}\t| #{@last_loc}\t|"  
  end

  def show_loc
    puts "Info of game"
    puts "Type: #{@type}   Current location: #{}"
  end
end

