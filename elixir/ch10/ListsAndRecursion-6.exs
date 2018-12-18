# Exercise: ListsAndRecursion-6
# Chapter 10, Page 102

defmodule MyList do
  def flatten(list) do
    case list do
      # Base Case: An empty list flattens to an empty list.
      [] -> []
      # Recursive Case #1: The head is an empty list. Ignore it.
      [ [] | tail ] -> flatten(tail)
      # Recursive Case #2: The head is a list. Flatten it.
      [ head = [ _ | _ ] | tail ] -> flatten(head) ++ flatten(tail)
      # Recursive Case #3: The head is a value.
      [ head | tail ] -> [head] ++ flatten(tail)
    end
  end
end

# Test Cases.
IO.inspect MyList.flatten([[[]]])
IO.inspect MyList.flatten([1, []])
IO.inspect MyList.flatten([[[[1]], 2]])
IO.inspect MyList.flatten([1, 2, 3])
IO.inspect MyList.flatten([[[1], 2], 3, [[[[4]]]]])
IO.inspect MyList.flatten([1, [2, []], 3, [[[[4]], 5]]])
