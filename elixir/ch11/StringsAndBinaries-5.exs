# Exercise: StringsAndBinaries-5
# Chapter 11, Page 130

defmodule MyString do

  # Find the length of the longest string.
  defp _longest_length(list) do
    List.foldr(list, 0, fn x, acc ->
      if String.length(x) > acc do
        String.length(x)
      else
        acc
      end
    end)
  end

  # Compute left padding.
  defp _compute_padding(string, longest) do
    length = String.length(string)
    length + div(longest - length, 2)
  end

  # Format and print.
  def center(list) do
    width = _longest_length(list)

    list
    |> Enum.map(fn s -> String.pad_leading(s, _compute_padding(s, width)) end)
    |> Enum.each(&IO.puts/1)
  end

end

# Output result.
MyString.center(["cat", "zebra", "elephant"])
