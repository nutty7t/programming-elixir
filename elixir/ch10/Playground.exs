# Just trying to understand what Stream.unfold/2 does...
# I'm thinking that I might be able to grok what unfold does
# by relating it to fold[l|r].

# The idea behind fold is to reduce a list to a single value.
fold_result = List.foldr([1, 1, 1, 1, 1], 0, fn x, acc -> x + acc end)

# With unfold, we're starting with a single value, and
# generating a list from that value.
unfold_result = Stream.unfold(5, fn
  # Same as the initial value in fold!
  0 -> nil
  # Inverse function! The first value is analagous to each
  # element in the input list in fold. The second value is
  # analagous to our accumulator in fold.
  n -> {1, n - 1}
end) |> Enum.to_list() 

IO.inspect(fold_result)
IO.inspect(unfold_result)

# [NOTE] Stream.iterate is like the scan operation in ReactiveX
# lingo and the accumulate function in the Python Toolz API.

# [NOTE] Stream.resource is basically a generator function that
# uses a resource to generate stream values. The first and third
# arguments handle allocation and deallocation when the stream
# begins to get consumed and when the stream is done with the resource.
# So, it's kind of like RAII in Elixir. Yay, no resource leaks!
