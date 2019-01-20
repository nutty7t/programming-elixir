# Exercise: ControlFlow-1
# Chapter 12, Page 139

defmodule FizzBuzz do
  def solver(n) when n > 0 do
    1..n |> Enum.map(&fizzbuzz/1)
  end

  defp fizzbuzz(n) do
    case {n, rem(n, 3), rem(n, 5)} do
      {_n, 0, 0} -> "FizzBuzz"
      {_n, 0, _} -> "Fizz"
      {_n, _, 0} -> "Buzz"
      { n, _, _} -> n
    end
  end 
end

# Test Driver.
IO.inspect FizzBuzz.solver(100)
