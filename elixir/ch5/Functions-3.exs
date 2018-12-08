# Exercise: Functions-3
# Chapter 5, Page 45

fizzbuzz_aux = fn
  (0, 0, _) -> "fizzbuzz"
  (0, _, _) -> "fizz"
  (_, 0, _) -> "buzz"
  (_, _, x) -> "#{x}"
end

# A FizzBuzz solution without conditional logic.
fizzbuzz = fn n -> fizzbuzz_aux.(rem(n, 3), rem(n, 5), n) end

IO.puts fizzbuzz.(10)
IO.puts fizzbuzz.(11)
IO.puts fizzbuzz.(12)
IO.puts fizzbuzz.(13)
IO.puts fizzbuzz.(14)
IO.puts fizzbuzz.(15)
IO.puts fizzbuzz.(16)
