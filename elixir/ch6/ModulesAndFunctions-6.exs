# Exercise: ModulesAndFunctions-6
# Chapter 6, Page 62

defmodule Chop do
  def guess(actual, min..max) do
    g = div(min + max, 2)
    IO.puts("Is it #{g}")
    cond do
      g > actual -> guess(actual, min..g - 1)
      g < actual -> guess(actual, g + 1..max)
      true       -> g
    end
  end
end
