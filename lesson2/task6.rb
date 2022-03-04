# 6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара 
# (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" 
# в качестве названия товара. На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, 
# содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

cart = {}
total = 0

loop do

  print "Введите товар: "
  item = gets.chomp

  break if item == "стоп"

  print "Введите цену: "
  price = gets.chomp.to_f
  print "Введите количество: "
  count = gets.chomp.to_i

  if cart.has_key?(item)
    cart[item][:price] = (cart[item][:price] + price) / 2
    cart[item][:count] += count
  else
    cart[item] = {price: price, count: count}
  end

end

puts "-------------------------------------------------"
puts "|\tТовар\t|\tКол-во\t|\tСумма\t|"
puts "-------------------------------------------------"

cart.each do |key, value|
  total = value[:count] * value[:price]
  puts "|\t#{key}\t|\t#{value[:count]}\t|\t#{total}\t|"
end

puts "-------------------------------------------------"
puts "                                 ИТОГО: #{total}\t|"