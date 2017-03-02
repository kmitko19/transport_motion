# -------------------------------------------------------------------
# 2.  Объект: Светофоры
#      Свойства:   Расположение
#                  Длительность разрешающего сигнала
#                  Длительность запрещающего сигнала
#      Состояние:  Движение разрешено
#                  Движение запрещено
#                  Исправен
#                  Неисправен
#      Методы:     Показать длительность разрешающего сигнала
#                  Задать длительность разрешающего сигнала
#                  Показать длительность запрещающего сигнала
#                  Задать длительность запрещающего сигнала
#                  Показать техническое состояние
#                  Сломать
#                  Исправить
#                  Показать текущее значение сигнала
# Запрос на создание массива сфетофоров
def add_ligth
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
  @route_length = @route_list [input - 1].route_length
  id_route = input
  @route_length = @route_list [0].route_length
=end  
  id_route = 1
  while true    
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
      puts "Query of game"
      print "Add Traffic light? (Y/N): "
      input = gets.chomp  # проверка запроса на продолжение создания светофора
    end
    unless input  == "Y" or input  == "y"
      return
    end 
    # определение min допустимого значения
    min_length = 1
    if @ligth_list.size != 0
      arr = @ligth_list[@ligth_list.size - 1]
      min_length = arr.loc_ligth
    end 
    puts "Query of game"
    print "Set distance from start of route (km) \
       \nValid value from #{min_length} to #{@route_length}: "
    input = gets.chomp.to_i  
    
    if input <= 0 # проверка на положительное значение
    puts "Message of game"
    puts "Invalid value '#{input}'"    
    elsif input > @route_length # проверка на max
      puts "Message of game"
      puts "Distance cann't be more then '#{@route_length} km'"
    elsif input <= min_length # проверка на min
      puts "Message of game"
      puts "Distance cann't be less then '#{min_length}'"
    else      
      id_ligth = "ligth_" + "#{@ligth_list.size + 1}"      
      @ligth_list.push(instance_eval "@#{id_ligth} = Traffic_Ligth.new(id_ligth)")
      @ligth_list[@ligth_list.size - 1].loc_ligth = input
      @ligth_list[@ligth_list.size - 1].id_route = id_route
      puts "Query of game"
      puts "Set Traffic light #{id_ligth} \
          \nDistance from route start is #{input} km"    
    end    
  end  
end

# Показать светофоры и их состояние
def show_ligths
  if @ligth_list.size == 0
    puts "Message of game"
    puts "Traffic lights don't exist!"
    return
  end
  puts "Current state of Traffic ligths on the route \
      \n--------------------------------------------------------- \
      \n|  Name\t\t| Dist\t|T_Green| T_Red | Color | State |\
      \n---------------------------------------------------------"
  @ligth_list.each{|item| arr = item
    instance_eval "@#{arr.id_ligth}.show_ligth"
  }
  puts "---------------------------------------------------------"
end

# Изменить параметры светофора
def change_ligths
  if @ligth_list.size == 0
    puts "Message of game"
    puts "Traffic lights don't exist!"
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
      print "Add Traffic light? (Y/N): "
      input = gets.chomp 
    end
    unless input  == "Y" or input  == "y"
      return
    end 
    add_ligth
  end  
  if @ligth_list.size == 0
    return
  end
  puts "List of Traffic ligths \
      \n--------------------------------------------------------- \
      \n| Id |  Name\t| Dist\t|T_Green| T_Red | Color | State |\
      \n---------------------------------------------------------"
  i = 0
  @ligth_list.each{|item| arr = item; i += 1;
    print "| #{i}. "
    instance_eval "@#{arr.id_ligth}.show_ligth" 
  }
  puts "---------------------------------------------------------"
  puts "Query of game"
  print "Enter id of ligth (from 1 to #{@ligth_list.size}): "
  input = gets.chomp.to_i  
  if input < 1 || input > @ligth_list.size
    puts "Message of game"
    puts "Invalid value '#{input}'"
    return false
  end
  instance_eval "@#{@ligth_list[input - 1].id_ligth}.change_ligth"
end


# Описание класса "Светофор"
class Traffic_Ligth
  def initialize(id_ligth)
    @id_ligth = id_ligth
    @loc_ligth = 0          # Дистанция от начала маршрута
    @t_green = 1            # Длительность разрешающего сигнала
    @t_red = 1              # Длительность запрещающего сигнала
    @color_ligth = "green"  # Значение по умолчанию в начале движения
    @state_ligth = true     # Техническое состояние в начале движения
    @id_route = 0           # Идентификатор дороги
  end
  attr_accessor :id_ligth, :loc_ligth, :t_green, :t_red, :color_ligth, :state_ligth, :id_route

  # Показать светофоры и их состояние
  def show_ligth
    puts "| #{@id_ligth}\t|  #{@loc_ligth}\t|   #{@t_green}\t|   #{@t_red}\t| #{@color_ligth}\t| #{@state_ligth}\t|"  
  end

  # Изменить параметры светофора
  def change_ligth
    puts "Query of game"
    puts "Current duration of green is #{@t_green}"
    print "Enter new duration from 1 to 60: "
    input = gets.chomp.to_i
    if input <= 0 || input > 60
      puts "Message of game"
      puts "Invalid value '#{input}'"
    else
      @t_green = input
    end
    puts "Query of game"
    puts "Current duration of red is #{@t_red}"
    print "Enter new duration from 1 to 60: "
    input = gets.chomp.to_i
    if input <= 0 || input > 60
      puts "Message of game"
      puts "Invalid value '#{input}'"
    else
      @t_red = input
    end
    puts "Query of game"
    puts "Current color is #{@color_ligth}"
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
      print "To change the color? (Y/N): "
      input = gets.chomp 
    end
    if input  == "Y" or input  == "y"
      @color_ligth == "green" ? @color_ligth = "red" : @color_ligth = "green"
    end 
    puts "Query of game"
    puts "Current state is #{@state_ligth}"
    input = ""
    until input == "Y" or input == "y" or input == "N" or input == "n"
      print "To change the state? (Y/N): "
      input = gets.chomp 
    end
    if input  == "Y" or input  == "y"
      @state_ligth == true ? @state_ligth = false : @state_ligth = true
    end
    puts "Message of game"
    puts "New state of Traffic ligth on the route \
        \n--------------------------------------------------------- \
        \n|  Name\t\t| Dist\t|T_Green| T_Red | Color | State |\
        \n---------------------------------------------------------"
    puts "| #{@id_ligth}\t|  #{@loc_ligth}\t|   #{@t_green}\t|   #{@t_red}\t| #{@color_ligth}\t| #{@state_ligth}\t| \
        \n---------------------------------------------------------"
  end
end 

