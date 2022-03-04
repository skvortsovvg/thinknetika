# 3. Заполнить массив числами фибоначчи до 100

arr = [0]; n = 1

while n < 100 do
  arr << n
  n = arr.last + arr[-2]
end

puts arr.inspect