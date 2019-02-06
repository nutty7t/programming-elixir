# Exercise: Nodes-1
# Chapter 16, Page 222

# In one terminal:
#   $ iex --sname foo Nodes-1.exs
#
# In another terminal:
#   $ iex --sname bar Nodes-1.exs
#   iex> Node.connect :foo@nuttycloud
#   iex> Node.spawn :foo@nuttycloud, &NodeTest.list_dir/0
#
#   ... (directory contents of foo) ...

defmodule NodeTest do
  def list_dir() do
    IO.puts Enum.join(File.ls!, ",")
  end
end

