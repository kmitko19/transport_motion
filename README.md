# transport_motion
Game on Ruby
# Программа позволяет получить состояние дорожного движения в заданный момент времени
# Объекты движения: заданные (объявленные транспортные средства).
# Количество транспортных средств определяется пользователем
# Регулировка движения: Светофор
# Количество светофоров определяется пользователем

# 1.  Класс: Дорога
#      Свойства:   Длина
#      Методы:     Показать длину
#                  Задать(изменить) длину (только до начала движения)
# 2.  Класс: Светофоры
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

#     Алгоритм
#
# 1.    Приветствие запрос имени: если "", то выход (6.)
#       Предложение поиграть: N, то выход (6.)
# 2. Задание исходных данных:
# 
# 2.1 Ввод длины дороги (км): если "" или < 1, то сообщение об ошибке и предложение ввести
#     данные повторно, либо отказаться
# 2.2 Расстановка светофоров (км от начала дороги). Каждый следующий светофор должен стоять
#     дальше по дороге от предыдущего. Задание текущего состояния.
#     Проверки на корректность ввода, как в 2.3
# 2.3 Объявление транспортных средств и ввод средней скорости для каждого транспортного средства
# 2.4 Изменение при необходимости параметров светофоров и транспортных средств
#
# 3. Запуск движения
#
# 4. Изменение состояния светофоров и транспортных средств
#
# 5. Мониторинг состояния дорожного движения на заданный момент времени (мин с начала старта
#    или от времени последнего мониторинга)
#
# 6. Выход из программы


# Порядок использования:
# 1. Разместить файлы в одном директории
# 2. Запустить консоль и перейти в директорий с файлами игры
# 3. Запустить irb командой: irb -I .
# 4. Выполнить команду: require "motion_main"
# 5. Выполнить команду: motion
# 6. Остальные комментарии выдаются по ходу выполнения программы
#
#
#
#
#
#
#