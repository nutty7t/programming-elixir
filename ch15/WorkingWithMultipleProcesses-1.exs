# Exercise: WorkingWithMultipleProcesses-1
# Chapter 15, Page 206

# Here are my results:
#
# Processes | Time
# ----------+----------
# 10        | 2521
# 100       | 3752
# 1000      | 10375
# 10000     | 45884
# 100000    | 450726
# 1000000   | 4539252
#
# My numbers seem to match up with Dave's. After about the 10,000
# process mark, the execution time starts scale linearly.

defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n + 1
    end
  end

  def create_processes(n) do
    code_to_run = fn (_, send_to) ->
      spawn(Chain, :counter, [send_to])
    end

    last = Enum.reduce(1..n, self(), code_to_run)
    send(last, 0)

    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    :timer.tc(Chain, :create_processes, [n])
    |> IO.inspect
  end
end

