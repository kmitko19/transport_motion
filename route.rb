# 1.  Объект: Дорога
#      Свойства:   Длина
#      Методы:     Показать длину
#                  Задать(изменить) длину (только до начала движения)

# Описание класса "Маршрут"
def change_route
  # проверка статуса игры
  if @flag_game == true 
    puts "!"
    puts "You can't change the length of the route, \
        \nbecause traffic is already activated!"
    return
  end
  # проверка наличия светофоров    
  if @ligth_list.size > 0
    puts "!"
    puts "You can't change the length of the route, \
        \nbecause traffic ligths were installed!"
    return
  end
  @road.change_length  
  @route_length = @road.route_length
end

class Route
  def initialize
    @route_length = 50 
  end
  attr_accessor :route_length
  # Показать длину маршрута ---------------------------------------------
  def show_length
    puts "*"
    puts "Route length is #{@route_length} km"
  end
  # Изменить длину маршрута ---------------------------------------------
  def change_length    
    puts ">"
    print "Route length is #{@route_length} km \
          \nSet the new value of route length in km: "
    input = gets.chomp.to_i
    
    # проверка введенного значения     
    if input <= 0
      puts "!"
      puts "Invalid value '#{input}' \
          \nRoute length is unchanged and equal to #{@route_length} km"
    else # Задание нового значение длины маршрута
      @route_length = input
      puts "*"
      puts "New route length is #{@route_length} km"
    end    
  end
end

