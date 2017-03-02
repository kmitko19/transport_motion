# 4.  Метод: Общее состояние дорожного движения на заданный
# момент времени от начала движения

def monitor
  @route_m = []
  @veh_m = []
  @ligth_m = []
  # проверка наличия транспортных средств на дороге
  if @flag_game == false
    puts "!"
    puts "The game is not activated"
    return
  else
    
  end
  if @vehicle_list.size == 0
    puts "!"
    puts "Vehicles don't exist!"    
    return
  end 
  # ввод интервала от времени последнего мониторинга
  puts ">"
  print "Enter time from last monitoring (min):"
  input = gets.chomp.to_i
  if input <= 0
    puts "!"
    puts "Invalid value '#{input}'"
    return
  else
    duration = input  # Интервал
    @last_time = @last_time + input
  end
  # формирование временного пустого массива для заполнения массива
  # размещения транспорта на дороге
  i = 0
  while i < @route_length
    i += 1
    arr_v = []
    j = 0
    while j < @vehicle_list.size    
      arr_v.push("")
      j += 1
    end   
    @veh_m.push(arr_v)     
  end 
  # создание пустого массива размещения светофоров на дороге,
  # а также создание массива километража дороги
  i = 0
  while i < @route_length
    i += 1
    @route_m.push(i)    
    @ligth_m.push("")    
  end
  # заполнение массива светофоров на дороге
  if @ligth_list.size > 0
    i = 0
    @ligth_list.each {|item| 
      @ligth_m[@ligth_list[i].loc_ligth - 1] = @ligth_list[i].id_ligth
      i += 1
    }
  end

  # заполнение массива транспорта на дороге
  i = 0
  @vehicle_list.each {|item|
    speed_min = @vehicle_list[i].speed / 60 .to_f    
    distance = speed_min * duration
    veh_loc = @vehicle_list[i].last_loc + distance
    veh_loc = veh_loc.round
    if veh_loc > @route_length
      veh_loc = @route_length
      puts "!"
      puts "Vehicle '#{@vehicle_list[i].type}' completed the route"      
    end
    @vehicle_list[i].last_loc = veh_loc    
    @veh_m[veh_loc - 1][i] = @vehicle_list[i].type    
    i += 1
  }
  
  i = 0
  arr_v = []
  while i < @route_length    
    print "#{@route_m[i]}\t"
    arr_v = @veh_m[i]
    j = 0
    arr_v.each{
      print "#{arr_v[j]}\t" 
      j += 1
    }
    puts "#{@ligth_m[i]}"
    i += 1
  end
end

