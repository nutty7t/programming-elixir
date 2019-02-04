# Exercise: WorkingWithMultipleProcesses-7
# Chapter 15, Page 211

defmodule Parallel do
  def pmap(collection, fun) do
    collection
    |> Enum.map(fn (elem) ->
      # Because we're not defining an anonymous function here,
      # there is no need for the `me` variable.
      spawn_link Parallel, :show_bug, [elem, self(), fun]
    end)
    |> Enum.map(fn (pid) ->
      # No pinning will cause `pmap` to bug out.
      # iex warns you that `pid` is unused.
      receive do {pid, result} -> result end
    end)
  end

  def show_bug(elem, pid, fun) do
    # Sleeping will reveal the bug.
    :timer.sleep Enum.random(100..1000)
    send pid, {self(), fun.(elem)}
  end
end

