# Exercise: ModulesAndFunctions-3
# Chapter 6, Page 55

defmodule Times do
    def double(n), do: n * 2
    def triple(n), do: n * 3

    # Maybe it could call the `double` function... TWICE!
    def quadruple(n), do: n |> double |> double
end
