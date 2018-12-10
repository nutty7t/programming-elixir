# Exercise: ListsAndRecursion-1
# Chapter 7, Page 77

defmodule Awesome do

  def map([], _func) do 
    []
  end

  def map([ head | tail ], func) do
    [ func.(head) | map(tail, func) ]
  end

  def reduce([], accumulator, _func) do
    accumulator
  end

  def reduce([ head | tail ], accumulator, func) do
    reduce(tail, func.(accumulator, head), func)
  end

  def mapsum(list, func) do
    list |> map(func) |> reduce(0, &(&1 + &2))
  end

end
