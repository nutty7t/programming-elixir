# Notes on "A tutorial on the universality and expressiveness of fold" -- Graham Hutton.

defmodule Fold do
  # Just importing Quark for partials. Everything in this tutorial
  # is curried, so this should make it easier to translate into Elixir.
  use Quark.Partial

  # foldr :: (α → β → β) → β → ([α] → β)
  defpartial foldr(func, accumulator, list) do
    # [NOTE] At first, I wrote `foldr` as two separate clauses;
    # but because `defpartial` uses up the full-arity space, it
    # didn't work. I almost refactored the function to use `defcurry`,
    # but then I remembered that pattern matching is a thing and
    # I can use it to refactor the definition into one clause.
    case list do
      [] -> accumulator
      [h | t] -> func.(h, foldr(func, accumulator, t))
    end
  end

  # sum :: [Number] -> Number
  def sum(list), do: foldr(&+/2, 0).(list)

  # product :: [Number] -> Number
  def product(list), do: foldr(&*/2, 1).(list)

  # all :: [Bool] -> Bool
  def all(list), do: foldr(&and/2, true).(list)

  # any :: [Bool] -> Bool
  def any(list), do: foldr(&or/2, false).(list)

  # append (++) :: [α] → [α] → [α]
  defpartial append(x, y) do
    # Represent the | operator as an anonymous function
    # because, evidently, &|/2 doesn't exist.
    cons = fn h, t -> [h | t] end
    # Why do we use `y` as initial accumulator value?
    # Let's draw a diagram of [1, 2, 3] ++ [4, 5, 6]:
    #
    #        : (cons)
    #       / \
    #      1   :
    #         / \
    #        2   :
    #           / \
    #          3  [4, 5, 6] (accumulator)
    #
    foldr(cons, y).(x)
  end

  # length :: [α] → Int
  def length(list), do: foldr(fn _, acc -> acc + 1 end, 0).(list)

  # reverse :: [α] → [α]
  def reverse(list), do: foldr(fn x, acc -> acc ++ [x] end, []).(list)

  # map :: (α → β) → ([α] → [β])
  defpartial map(func, list) do 
    foldr(fn x, acc -> [func.(x) | acc] end, []).(list)
  end

  # filter :: (α → Bool) → ([α] → [α])
  defpartial filter(func, list) do
    foldr(fn x, acc ->
      if func.(x) do
        [x | acc]
      else
        acc
      end
    end, []).(list)
  end

  # [TODO] To be continued...

end
