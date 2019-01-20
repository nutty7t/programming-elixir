# Exercise: ModulesAndFunctions-4
# Chapter 6, Page 57

defmodule Exercise do
  def sum(1), do: 1
  def sum(n) when n > 1, do: n + sum(n - 1)
end
