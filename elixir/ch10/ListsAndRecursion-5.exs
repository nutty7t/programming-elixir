# Exercise: ListsAndRecursion-5
# Chapter 10, Page 102

defmodule MyEnum do
    
  # It is stylistically preferable to end a function name
  # with a '?' if the function returns a boolean value.
  def all?([], _fun) do
    true
  end

  def all?([ head | tail ], fun) do
    fun.(head) and all?(tail, fun)
  end

  def each([], _fun) do
    :ok
  end

  def each([ head | tail ], fun) do
    fun.(head)
    each(tail, fun)
  end

  def filter([], _fun) do
    []
  end

  def filter([ head | tail ], fun) do
    if fun.(head) do
      [ head | filter(tail, fun) ]
    else
      filter(tail, fun)
    end
  end

  # Implementation not required by the exercise, but it
  # will be used in split/2 to handle negative counts.
  def size([]) do
    0
  end

  def size([ _head | tail ]) do
    1 + size(tail)
  end

  # I'm not so sure if this is a good way to approach
  # implementing the split/2 function in FP. I may be
  # stuck in the Prolog way of thinking.
  defp split_aux(accumulator, [], _count) do
    { accumulator, [] }
  end

  defp split_aux(accumulator, list, 0) do
    { accumulator, list }
  end

  defp split_aux(accumulator, [ head | tail ], count) do
    split_aux(accumulator ++ [head], tail, count - 1)
  end

  def split(list, count)
  when count >= 0 do
    split_aux([], list, count)
  end

  def split(list, count)
  when count < 0 do
    len = size(list)
    normalized_count = len + count

    # max(normalized_count, 0)
    if normalized_count >= 0 do
      split_aux([], list, normalized_count)
    else
      split_aux([], list, 0)
    end
  end

  def take(list, amount)
  when amount >= 0 do
    { values, _ } = split(list, amount)
    values
  end

  def take(list, amount)
  when amount < 0 do
    { _, values } = split(list, amount)
    values
  end

end
