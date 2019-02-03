# Exercise: WorkingWithMultipleProcesses-3
# Chapter 15, Page 210

defmodule WorkingWithMultipleProcesses do
  def say_hi_and_die(parent) do
    send parent, "hi"
  end

  def parent_process do
    spawn_link(WorkingWithMultipleProcesses, :say_hi_and_die, [self()])

    # Sleep for 500ms.
    # Does it matter if we aren't receiving notifications yet?
    :timer.sleep(500)

    # It looks like it doesn't matter. Output:
    #
    #   iex> WorkingWithMultipleProcesses.parent_process()
    #   Received message: hi
    #   :ok
    receive do
      msg ->
        IO.puts "Received message: #{msg}"
    end
  end
end

