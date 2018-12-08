# Exercise: Functions-1
# Chapter 5, Page 43

list_concat = fn (x, y) -> x ++ y end
sum = fn (a, b, c) -> a + b + c end
pair_tuple_to_list = fn { a, b } -> [a, b] end

list_concat.([:a, :b], [:c, :d]) #=> [:a, :b, :c, :d]
sum.(1, 2, 3)                    #=> 6
pair_tuple_to_list.({123, 456})  #=> [123, 456]
