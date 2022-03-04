# # 5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). 
# # Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. 
# # (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?) 
# # 	Алгоритм опредления високосного года: docs.microsoft.com
# # Если год делится на 4 без остатка, перейдите на шаг 2. В противном случае перейдите к выполнению действия 5.
# # Если год делится на 100 без остатка, перейдите на шаг 3. В противном случае перейдите к выполнению действия 4.
# # Если год делится на 400 без остатка, перейдите на шаг 4. В противном случае перейдите к выполнению действия 5.
# # Год високосный (366 дней).
# # Год не високосный год (365 дней).

def is_leap?(year)

  return false if year % 4 > 0

  if year % 100 == 0
    return year % 400 == 0 ? true : false
  else
  	return true
  end

  return false

end

print "Введите день: "
d = gets.chomp.to_i
print "Введите месяц: "
m = gets.chomp.to_i
print "Введите год: "
y = gets.chomp.to_i

year = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
year[1] += 1 if is_leap?(y)

n = d
1.upto(m-1) { |i| n += year[i-1]}

puts n