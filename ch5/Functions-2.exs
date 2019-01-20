# Exercise: Functions-2
# Chapter 5, Page 45

fizzbuzz = fn
  (0, 0, _) -> "fizzbuzz"
  (0, _, _) -> "fizz"
  (_, 0, _) -> "buzz"
  (_, _, x) -> "#{x}"
end

IO.puts fizzbuzz.(0, 0, 1)
IO.puts fizzbuzz.(0, 2, 2)
IO.puts fizzbuzz.(3, 0, 3)
IO.puts fizzbuzz.(4, 4, 4)
