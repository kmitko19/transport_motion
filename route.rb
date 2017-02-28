# 1.  Объект: Дорога
#      Свойства:   Длина
#      Методы:     Показать длину
#                  Задать(изменить) длину (только до начала движения)

# Переменные экземпляра класса Class
@route_list = []   # длина маршрута

# Описание класса "Маршрут"
def change_route
  # проверка статуса игры
  if @flag_game == true 
    puts "----------------------------------------- \
        \nYou can't change the length of the route, \
        \nbecause traffic is already activated! \
        \n-----------------------------------------"
    return
  end
  # проверка наличия светофоров    
  if @ligth_list.size > 0
    puts "----------------------------------------- \
        \nYou can't change the length of the route, \
        \nbecause traffic ligths were installed! \
        \n-----------------------------------------"
    return
  end
  @road.change_length
end

class Route
  def initialize
    @route_length = 50 
  end
  attr_accessor :route_length
  # Показать длину маршрута ---------------------------------------------
  def show_length
    puts "------------------------------------------- \
        \nRoute length is #{@route_length} km \
        \n-------------------------------------------"
  end
  # Изменить длину маршрута ---------------------------------------------
  def change_length    
    print "----------------------------------------- \
          \nRoute length is #{@route_length} km \
          \nSet the new value of route length in km: "
    input = gets.chomp.to_i
    
    # проверка введенного значения     
    if input <= 0
      puts "------------------------------------------------------------- \
          \nInvalid value '#{input}' \
          \nRoute length is unchanged and equal to #{@route_length} km \
          \n-------------------------------------------------------------"
    else # Задание нового значение длины маршрута
      @route_length = input
      puts "------------------------------------------- \
          \nNew route length is #{@route_length} km \
          \n-------------------------------------------"
    end    
  end
end
@road = Route.new
@route_list.push(@road)
