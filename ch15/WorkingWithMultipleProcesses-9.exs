# Exercise: WorkingWithMultipleProcesses-9
# Chapter 15, Page 215

# Running both of the cat counters on a dual-core droplet
# against 1.93 GB of text:
#
#   5,457,375 μs vs. 2,877,312 μs
#   Almost a 2x speedup!

defmodule CatCounter do
  def worker(scheduler_pid) do
    send scheduler_pid, {:ready, self()}
    receive do
      # Work is complete.
      {:shutdown} ->
        exit(:normal)

      # Count the cats.
      {filename} ->
        cats = filename |> File.read! |> count_cats
        send scheduler_pid, {{filename, cats}, self()}
        worker(scheduler_pid)
    end
  end

  def lonely_worker(queue) do
    # Count the cats... alone.
    queue
    |> Enum.map(fn filename ->
      {
        filename,
        filename
        |> File.read!
        |> count_cats
      }
    end)
    |> Enum.sort()
  end

  defp count_cats(file_contents) do
    file_contents
    |> String.split(~r/cat/i)
    |> length
    |> Kernel.-(1)
  end
end

defmodule Scheduler do
  def run(process_count, module, func, queue) do
    (1..process_count)
    |> Enum.map(fn _ -> spawn(module, func, [self()])  end)
    |> schedule_processes(queue, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      # Schedule work.
      {:ready, pid} when queue != [] ->
        [next | tail] = queue
        send pid, {next}
        schedule_processes(processes, tail, results)

      # Work is complete.
      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      # Receive and accumulate results.
      {result, _pid} ->
        schedule_processes(processes, queue, [result | results])
    end
  end
end

queue = File.ls!()
IO.inspect :timer.tc(CatCounter, :lonely_worker, [queue])
IO.inspect :timer.tc(Scheduler, :run, [10, CatCounter, :worker, queue])

