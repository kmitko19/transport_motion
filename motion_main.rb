# Домашнее задание
#   Написать программу пошаговой стратегии, пользуясь которой я могу:
#   • Создавать объекты автомобиля, велосипеда, дороги, светофора и его режима работы.
#   • Запускать на дорогу автомобили, чтобы они останавливались когда горит красный свет,
#     и ехали когда горит зеленый свет.
#   • Задача со звездочкой - спровоцировать аварию с поломкой светофора.
#===============================================================================================
# Решение
 
# Программа позволяет получить состояние дорожного движения в заданный момент времени
# Объекты движения: Автомобиль, Трамвай, Велосипед
# Регулировка движения: Светофор

# Переменные экземпляра класса Class
@flag_game = false # флаг состояния игры

require_relative 'route.rb'
require_relative 'ligths.rb'
require_relative 'vehicles.rb'
# I. Общий алгоритм выполнения программы
def motion
# 1. Вход в программу
#       Приветствие запрос имени: если "", то выход (6.)
#       Предложение поиграть: N, то выход (6.)
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
# 2. Задание исходных данных:
#     - длина дороги (км)
  # requiry_relative 'router.rb'
  puts "There is route 'Road', which length #{@route_length} km"
  input = ""
  until input == "Y" or input == "y" or input == "N" or input == "n"
    print "Change length? (Y/N): "
    input = gets.chomp 
  end
  if input  == "Y" or input  == "y"      
    change_route
  end
#     - расстановка светофоров (км от начала дороги), задание длительности сигналов (мин)
#       и исходное состояние
  add_ligth

#     - задание средней скорости транспортных средств (км/ч), их исходного
#       расположения (км от начала дороги) и их текущего состояния
  add_veh
# 2.1 Вывод параметров по умолчанию
# 2.2 Предложение изменить исходные параметры: No, то переход к запуску (3.)
# 2.3 Ввод длины дороги (км): если "" или < 1, то сообщение об ошибке и предложение ввести
#     данные повторно, либо отказаться
# 2.4 Расстановка светофоров (км от начала дороги). Каждый следующий светофор должен стоять
#     дальше по дороге от предыдущего. Задание текущего состояния.
#     Проверки на корректность ввода, как в 2.3
# 2.5 Ввод средней скорости для каждого транспортного средства, их расположение на дороге и
#     текущего состояния
# 3. Запуск движения
# 4. Изменение состояния светофоров и транспортных средств. Задается время в мин от начала
#    движения, но не ранее последнего времени мониторинга или предыдущего изменения состояния
# 5. Мониторинг состояния дорожного движения на заданный момент времени (мин с начала старта),
#    но не ранее последнего времени  изменения состояния или предыдущего мониторинга
# 6. Выход из программы
  puts "====================================================="
  puts "Initialization finished. Current state of the route:"
  @road.show_length
  show_ligths
  show_vehs
  help_game
  while true    
    print "Enter control command: (help -'H')"
    symb = gets.chomp
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


