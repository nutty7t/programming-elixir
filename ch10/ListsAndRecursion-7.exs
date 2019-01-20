# Exercise: ListsAndRecursion-7
# Chapter 10, Page 114

defmodule MyList do

  defp span(x, x) do
    [x]
  end

  defp span(from, to)
  when from <= to do
    [ from | span(from + 1, to) ]
  end

  defp is_prime?(2) do
    true
  end

  defp is_prime?(n)
  when n > 2 do
    span(2, n - 1) |> Enum.all?(fn x -> rem(n, x) != 0 end)
  end

  def primes(n)
  when n > 2 do
    for x <- span(2, n), is_prime?(x), do: x
  end

end

# Test Driver.
IO.inspect MyList.primes(300)
