# Exercise: Functions-5
# Chapter 5, Page 50

Enum.map [1, 2, 3, 4], &(&1 + 2) #=> [3, 4, 5, 6]
IO.puts Enum.each [1, 2, 3, 4], &IO.inspect/1
