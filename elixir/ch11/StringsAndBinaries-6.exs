# Exercise: StringsAndBinaries-6
# Chapter 11, Page 131

defmodule MyString do
  def capitalize(sentences) do
    sentences
    |> String.split(". ")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(". ")
  end
end

IO.inspect MyString.capitalize("oh. a DOG. woof. ")
