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

# Метод выбора транспортного средства
@vehicle_list = []

def add_veh
  # проверка статуса игры
  if @flag_game == true 
    puts "----------------------------------------- \
        \nYou can't add traffic ligth, \
        \nbecause the traffic is already activated! \
        \n-----------------------------------------"
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
      print "Add Vehicle? (Y/N): "
      input = gets.chomp  # проверка запроса на продолжение создания светофора
    end
    unless input  == "Y" or input  == "y"
      return
    end    
    print "Enter type of vehicle: "
    input = gets.chomp
    if input == ""
      puts "You not entered type!"      
    else
      type = input
      print "Enter speed of vehicle: "
      input = gets.chomp
      input = input.to_i
      if input <= 0 || input > 200
        puts "Invalid value '#{input}'"        
      else
        speed = input
        # создание нового экземпляра транспортного средства    
        @vehicle_list.push(instance_eval "@#{type} = Vehicle.new(type, speed)")
        @vehicle_list[@vehicle_list.size - 1].id_route = id_route
        puts "---------------------------------------------- \
              \nNew vehicle '#{type}'. Speed: '#{speed}' km \
              \n----------------------------------------------"
      end 
      
    end    
  end
end

# Изменить параметры транспортного средства
def change_veh
  if @vehicle_list.size == 0
    puts "--------------------- \
        \nVehicles don't exist! \
        \n---------------------"
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
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
  puts "-------------------------------------------------"
  print "Enter id of vehicle (from 1 to #{@vehicle_list.size}): "
  input = gets.chomp  
  input = input.to_i  
  if input < 1 || input > @vehicle_list.size
    puts "Invalid value '#{input}'"
    return false
  end

  while true
    puts "------------------------ \
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
    puts "--------------------- \
        \nVehicles don't exist! \
        \n---------------------"
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
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

  attr_accessor :speed, :move_state, :tech_state, :type, :id_route
 
# Метод изменения скорости транспортного средства  
  def change_speed    
    puts "-------------------------------------------- \
        \nType: #{@type}   Current speed: #{@speed} \
        \n--------------------------------------------"
    print "Enter new speed of vehicle (from 1 to 200): "    
    input = gets.chomp
    input = input.to_i
    if input <= 0 || input > 200
      puts "Invalid value '#{input}'"
      return
    else
      @speed = input
      puts "-------------------------------------------- \
          \nType: #{@type}   New speed: #{@speed} \
          \n--------------------------------------------"
    end
  end

# Метод изменения статуса движения транспортного средства  
  def change_move    
    puts "-------------------------------------------- \
        \nType: #{@type}   Current state: #{@move_state} \
        \n--------------------------------------------"
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
      print "To change the state? (Y/N): "
      input = gets.chomp 
    end
    if input  == "Y" or input  == "y"      
      @move_state == "stand" ? @move_state = "moves" : @move_state = "stand"
      puts "-------------------------------------------- \
          \nType: #{@type}   New state: #{@move_state} \
          \n--------------------------------------------" 
    end
  end

# Метод изменения технического состояния транспортного средства  
  def change_tech    
    puts "-------------------------------------------- \
        \nType: #{@type}   Current state: #{@tech_state} \
        \n--------------------------------------------"
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
      print "To change the state? (Y/N): "
      input = gets.chomp 
    end
    if input  == "Y" or input  == "y"      
      @tech_state == true ? @tech_state = false : @tech_state = true
      puts "-------------------------------------------- \
          \nType: #{@type}   New state: #{@tech_state} \
          \n--------------------------------------------" 
    end
  end

  def show_veh
    puts "| #{@type}\t|  #{@speed}\t| #{@move_state} | #{@tech_state}\t| #{@last_loc}\t|"  
  end

  def show_loc
    puts "-------------------------------------------- \
        \nType: #{@type}   Current location: #{} \
        \n--------------------------------------------"
  end
end

#*********************************************************************************************

# 4.  Метод: Общее состояние дорожного движения на заданный момент времени от начала движения
def monitor
  if @ligth_list.size == 0
    puts "--------------------------------------------------- \
         \nTraffic lights do not exist \
         \n---------------------------------------------------"
  else
    puts "Current state of Traffic ligths on the route \
        \n--------------------------------------------------------- \
        \n|  Name\t\t| Dist\t|T_Green| T_Red | Color | State |\
        \n---------------------------------------------------------"     
    i=0
    @ligth_list.each {|item| arr = item; i +=1; 
    puts "| Ligth#{i}\t|  #{arr[0]}\t|   #{arr[1]}\t|   #{arr[2]}\t| #{arr[3]}\t| #{arr[4]}\t| \
        \n---------------------------------------------------------"
    }    
  end
end

