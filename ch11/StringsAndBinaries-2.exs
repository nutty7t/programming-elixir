# Exercise: StringsAndBinaries-2
# Chapter 11, Page 123

defmodule Monkey do # 🐒

  defp all_spaces?([]) do
    true
  end

  defp all_spaces?([ head | tail ]) do
    if head == ?\s do
      all_spaces?(tail)
    else
      false
    end
  end

  # [NOTE] This is just an exercise so I didn't bother
  # addressing all of the edge cases, so...
  #   - letter case must match
  #   - only ignores space characters
  def anagram?([], word), do: all_spaces?(word)
  def anagram?(word, []), do: all_spaces?(word)
  def anagram?([ head | tail ], other_word) do
    cond do
      head == ?\s        -> anagram?(tail, other_word)
      head in other_word -> anagram?(tail, other_word -- [head])
      true               -> false
    end
  end

end

# Test Cases.
IO.inspect Monkey.anagram?(~c<listen>, ~c<silent>)
IO.inspect Monkey.anagram?(~c<i am lord voldemort>, ~c<tom marvolo riddle>)
IO.inspect Monkey.anagram?(~c<MY MASTER>, ~c<SYMMETRA>)
IO.inspect Monkey.anagram?(~c<foo>, ~c<bar>)
