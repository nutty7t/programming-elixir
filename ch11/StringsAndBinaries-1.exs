# Exercise: StringsAndBinaries-1
# Chapter 11, Page 123

defmodule Elephant do # 🐘

  def printable?([]) do
    true
  end

  def printable?([ head | tail ]) do
    if head < ?\s or head > ?~ do
      false
    else
      printable?(tail)
    end
  end

end

# Test Cases.
IO.inspect Elephant.printable?(~c<>)
IO.inspect Elephant.printable?(~c<foobar>)
IO.inspect Elephant.printable?(~c<foo bar>)
IO.inspect Elephant.printable?(~c<elephant 🐘>)
