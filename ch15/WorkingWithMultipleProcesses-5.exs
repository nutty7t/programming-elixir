# Exercise: WorkingWithMultipleProcesses-5
# Chapter 15, Page 210

# When we change `spawn_link` to `spawn_monitor`, we end up seeing "hi" even
# if the child throws an exception during the timer sleep.

defmodule WorkingWithMultipleProcesses do
  def say_hi_and_die(parent) do
    send parent, "hi"
  end

  def say_hi_and_boom(parent) do
    send parent, "hi"
    raise "BOOM!!!"
  end

  def parent_process_die do
    spawn_monitor(WorkingWithMultipleProcesses, :say_hi_and_die, [self()])
    :timer.sleep(500)
    receive do
      msg ->
        IO.inspect msg
    end
  end

  def parent_process_boom do
    spawn_monitor(WorkingWithMultipleProcesses, :say_hi_and_boom, [self()])
    :timer.sleep(500)
    receive do
      msg ->
        IO.inspect msg
    end
  end
end

