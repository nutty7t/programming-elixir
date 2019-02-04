# Exercise: WorkingWithMultipleProcesses-4
# Chapter 15, Page 210

defmodule WorkingWithMultipleProcesses do
  def say_hi_and_die(parent) do
    send parent, "hi"
    raise "BOOM!!!"
  end

  def parent_process do
    spawn_link(WorkingWithMultipleProcesses, :say_hi_and_die, [self()])

    # Sleep for 500ms.
    # Does it matter if we aren't receiving notifications yet?
    :timer.sleep(500)

    # If the child process crashes before the sleep ends, then "hi" will
    # never get printed in the receive clause. Output:
    #
    #   iex> WorkingWithMultipleProcesses.parent_process()
    #   20:54:46.403 [error] Process #PID<0.112.0> raised an exception
    #   ** (RuntimeError) BOOM!!!
    #       WorkingWithMultipleProcesses-4.exs:7: WorkingWithMultipleProcesses.say_hi_and_die/1
    receive do
      msg ->
        IO.puts "Received message: #{msg}"
    end
  end
end

