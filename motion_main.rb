# Домашнее задание
#   Написать программу пошаговой стратегии, пользуясь которой я могу:
#   • Создавать объекты автомобиля, велосипеда, дороги, светофора и его режима работы.
#   • Запускать на дорогу автомобили, чтобы они останавливались когда горит красный свет,
#     и ехали когда горит зеленый свет.
#   • Задача со звездочкой - спровоцировать аварию с поломкой светофора.
#===============================================================================================
 
# Программа позволяет получить состояние дорожного движения в заданный момент времени
# Объекты движения: транспортные средства
# Регулировка движения: Светофор


# Основной метод (метод запуска игры)
def motion

	# Переменные экземпляра класса Class
	@flag_game = false # флаг состояния игры
	@last_time = 0 # последнее время мониторинга движения
	@route_list = [] # массив маршрутов  
	@route_length = 0 # длина маршрута
	@ligth_list = []  # Массив светофоров
	@vehicle_list = [] # массив транспортных средств

	require_relative 'route.rb'
	require_relative 'ligths.rb'
	require_relative 'vehicles.rb'
	require_relative 'monitor.rb'

	@road = Route.new
	@route_list.push(@road)

# 1. Вход в программу
#       Приветствие запрос имени: если "", то выход
#       Предложение поиграть: N, то выход
  print "Hi! What's your name? "
  player = gets.chomp
  if player == ""
    puts "Invalid value, Bye!"
    return
  end
  puts "I'm glad to meet you, #{player}!"
  input = ""
  until input == "Y" or input == "y" or input == "N" or input == "n"
    print "Let's play a game 'Monitoring of transport motion? (Y/N): "
    input = gets.chomp 
  end
  if input  == "N" or input  == "n"      
    puts "Sorry, bye!" 
    return
  end
# изменение длины маршрута
  change_route
# расстановка светофоров (км от начала дороги)
  add_ligth
# определение транспортных средств и задание средней скорости транспортных средств (км/ч)
  add_veh
# вызов основного меню
  puts "====================================================="
  puts "Initialization finished. Current state of the route:"
  @road.show_length
  show_ligths
  show_vehs
  help_game
  while true    
    print "Enter control command (help -'H'): "
    symb = gets.chomp
    symb = 
    case symb
      when "H"
        help_game
      when "S"
        puts "Game started!"
        @flag_game = true
      when "RS"
        @road.show_length
      when "RC"
        change_route
      when "LS"
        show_ligths
      when "LC"
        change_ligths
      when "LA"
        add_ligth
      when "VS"
        show_vehs
      when "VC"
        change_veh
      when "VA"
        add_veh
      when "M"
        monitor
      when "Q"
        puts "Game is over! Good luck!"
        return
    end
  end
end

# Метод вызова помощи
def help_game
  puts "------------------------------------\
      \nControl command: \
      \nH - help \
      \nS - start of game \
      \nRS - show length of the route \
      \nRC - change length of the route \
      \nLS - show traffic ligths \
      \nLC - change state of traffic ligths \
      \nLA - add traffic ligth \
      \nVS - show state of vehicles \
      \nVC - change state of vehicles \
      \nVA - add vehicle \
      \nM - monitoring \
      \nQ - quit"  
end


