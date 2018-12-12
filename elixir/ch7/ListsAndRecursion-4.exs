# Exercise: ListsAndRecursion-4
# Chapter 7, Page 81

defmodule MyList do
    def span(x, x) do
        [x]
    end

    def span(from, to)
    when from <= to do
        [ from | span(from + 1, to) ]
    end
end
