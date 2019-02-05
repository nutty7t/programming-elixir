# Exercise: WorkingWithMultipleProcesses-7
# Chapter 15, Page 215


# Running this code on a 2-core DigitalOcean droplet. As expected,
# the performance flattens out after the number of processes exceeds
# two.
#
#   #     time (s)
#   1      17.24
#   2      9.55
#   3      9.40
#   4      8.92
#   5      9.00
#   6      9.10
#   7      8.96
#   8      9.47
#   9      8.95
#  10      9.11


defmodule FibSolver do
  def fib(scheduler) do
    # >> "Worker reporting for duty! OK, boss, what's my assignment?"
    send scheduler, {:ready, self()}

    receive do
      # << "Worker, you are to compute the next Fibonacci number."
      {:fib, n, client} ->

        # >> "Here's the number: #{fib_calc(n)}."
        send client, {:answer, n, fib_calc(n), self()}

        # >> "What should I do next?"
        fib(scheduler)

      # << "There's no more work that needs to be done."
      {:shutdown} ->

        # "Sweet, I can go home now.
        exit(:normal)
    end
  end

  # Inefficient computation.
  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)
end


defmodule Scheduler do
  @doc """
  Public API for the scheduler.

  ## Parameters

    - num_processes: Number of worker processes to spawn.
    - module: Module containing the function to spawn.
    - func: Function to spawn that does the work.
    - to_calculate: Process queue (list of things to process).
  """
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  @doc """
  Assigns work to different worker processes.

  ## Parameters

    - processes: List of worker processes.
    - queue: Process queue (list of things to process).
    - results: Accumulator that store the final results.
  """
  defp schedule_processes(processes, queue, results) do
    receive do
      # << "Worker reporting for duty! OK, boss, what's my assignment?"
      {:ready, pid} when queue != [] ->

        # Grab the next unit of work from the queue.
        [next | tail] = queue

        # >> "Worker, you are to compute the next Fibonacci number."
        send pid, {:fib, next, self()}

        # Keep assigning work until there's no more work to do.
        schedule_processes(processes, tail, results)

      # << "Worker reporting for duty! OK, boss, what's my assignment?"
      {:ready, pid} ->

        # >> "There's no more work that needs to be done."
        send pid, {:shutdown}

        if length(processes) > 1 do
          # Remove the worker from the worker list.
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          # Return the results when the last worker checks in.
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      # << "Here's the number: #{fib_calc(n)}."
      {:answer, number, result, _pid} ->

        # Append the Fibonacci number to results.
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end
end


# Test Driver.
to_process = List.duplicate(37, 20)

# Process the list 10 times, each time with an additional process.
Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler, :run,
    [num_processes, FibSolver, :fib, to_process]
  )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #     time (s)"
  end

  :io.format "~2B      ~.2f~n", [num_processes, time/1_000_000.0]
end

