# Exercise: ListsAndRecursion-2
# Chapter 7, Page 77

defmodule Awesome do

  def max([ head | tail ]) do
    # Because I implemented `reduce` in the previous exercise,
    # I'm allowed to use the built-in function here. Yes.
    Enum.reduce(tail, head, &max_of/2)
  end

  defp max_of(a, b) do
    cond do
      a >= b -> a
      true   -> b
    end
  end

end
