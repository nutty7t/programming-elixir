# Exercise: WorkingWithMultipleProcesses-6
# Chapter 15, Page 211

defmodule Parallel do
  def pmap(collection, fun) do
    # We need to assign the value of `self` to `me` because
    # `self` in the anonymous function definition refers to
    # the PID of the linked process instead of the PID of the
    # `pmap` parent process.
    me = self()
    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> (send me, {self(), fun.(elem)}) end
    end)
    |> Enum.map(fn (pid) ->
      receive do {^pid, result} -> result end
    end)
  end
end

