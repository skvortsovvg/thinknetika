# 1. Сделать хеш, содержащий месяцы и количество дней в месяце. 
# В цикле выводить те месяцы, у которых количество дней ровно 30

year = {Январь: 31, Февраль: 28, Март: 31, 
	Апрель: 30, Май: 31, Июнь: 30, Июль: 31, 
	Август: 31, Сентябрь: 30, Октябрь: 31, 
	Ноябрь: 30, Декабрь: 31}

year.map {|m, d| puts m if d == 30 }