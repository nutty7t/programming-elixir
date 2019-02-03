# Exercise: WorkingWithMultipleProcesses-2
# Chapter 15, Page 206

defmodule WorkingWithMultipleProcesses do
  def echoer() do
    receive do
      {sender, token} ->
        send sender, token
    end
  end

  def listener() do
    receive do
      token ->
        IO.puts token
        listener()
    end
  end

  def non_deterministic_echo() do
    # The order in which replies are received are non-deterministic in theory.
    # The process with pid2 could potentially run before process with pid1.
    # In practice, "donald" will virtually always be printed before "goofy".
    #
    # To make the order deterministic, you can make the following change:
    #
    # Before:
    #
    #                     ("donald")
    #   emitter -> pid1 -> receiver       Which comes first?
    #      |                                 There is no
    #      +-----> pid2 -> receiver        synchronization!
    #                      ("goofy")
    #
    # After:
    #
    #                     ("donald")
    #   emitter -> pid1 -> receiver -> pid1 ----+
    #      |                                    |
    #      |                                    V
    #      +---------------------------------> pid2 -> receiver
    #                                                  ("goofy")
    #
    #                               pid2 has a nested receive
    #                               block that waits for pid1

    receiver = spawn(WorkingWithMultipleProcesses, :listener, [])
    pid1     = spawn(WorkingWithMultipleProcesses, :echoer, [])
    pid2     = spawn(WorkingWithMultipleProcesses, :echoer, [])

    # Emitter.
    send pid1, {receiver, "donald"}
    send pid2, {receiver, "goofy"}
  end
end

