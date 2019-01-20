defmodule TestTest do
  use ExUnit.Case
  doctest Fold

  test "sum :: [Number] -> Number" do
    assert Fold.sum([]) == 0
    assert Fold.sum([1, 2, 3, 4, 5]) == 15
  end

  test "product :: [Number] -> Number" do
    assert Fold.product([]) == 1
    assert Fold.product([1, 2, 3, 4, 5]) == 120
  end

  test "all :: [Bool] -> Bool" do
    assert Fold.all([]) == true
    assert Fold.all([true, true, true, true]) == true
    assert Fold.all([true, true, false, true]) == false
  end

  test "any :: [Bool] -> Bool" do
    assert Fold.any([]) == false
    assert Fold.any([false, false, false]) == false
    assert Fold.any([false, true, false]) == true
  end

  test "append (++) :: [α] → [α] → [α]" do
    assert Fold.append([], []) == []
    assert Fold.append([1, 2], [3, 4]) == [1, 2, 3, 4]
    assert Fold.append([], [:bananas, :apples]) == [:bananas, :apples]
  end

  test "length :: [α] -> Int" do
    assert Fold.length([]) == 0
    assert Fold.length([1, 2, 3, 4]) == 4
  end

  test "reverse :: [α] → [α]" do
    assert Fold.reverse([]) == []
    assert Fold.reverse([1, 2, 3]) == [3, 2, 1]
  end

  test "map :: (α → β) → ([α] → [β])" do
    assert Fold.map(&String.upcase/1, []) == []
    assert Fold.map(&String.upcase/1, ["foo", "bar"]) == ["FOO", "BAR"]
  end

  test "filter :: (α → Bool) → ([α] → [α])" do
    assert Fold.filter(&is_integer/1, []) == []
    assert Fold.filter(&is_integer/1, ["foo", 42, :bar]) == [42]
  end
end
