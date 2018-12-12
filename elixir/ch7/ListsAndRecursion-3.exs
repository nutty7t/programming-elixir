# Exercise: ListsAndRecursion-3
# Chapter 7, Page 78

defmodule MyList do
  defp transform(rotate) do
    # WHAT?! Elixir doesn't have currying built
    # into the language? 😡
    fn (ascii) ->
      # Find 0-index of the letter.
      plain = ascii - 97
      # Perform the shift.
      cipher = rem(plain + rotate, 26)
      # Re-apply ASCII offset.
      cipher + 97
    end
  end

  def caesar([], _rotate) do
    []
  end

  # Precondition: `head` is between 'a' and 'z'.
  def caesar([ head | tail ], rotate)
  when head >= 97 and head <= 122 do
    [ transform(rotate).(head) | caesar(tail, rotate) ]
  end

  # ... or we can just use the Enum.map/2 function ...
  def caesar_with_map(list, rotate) do
    # ... but it doesn't assert the precondition ... 🤷🏼‍
    list |> Enum.map(transform(rotate)
  end
end
