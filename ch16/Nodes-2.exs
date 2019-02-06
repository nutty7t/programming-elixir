# Exercise: Nodes-2
# Chapter 16, Page 226

defmodule Ticker do
  @interval 2000
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator([pid|clients])
    after
      @interval ->
        IO.puts "tick"

        # Even though there is an explicit timeout of 2,000 ms,
        # it takes some additional time to enumerate over the
        # client list and send messages to each of the PIDs.

        Enum.each clients, fn client ->
          send client, {:tick}
        end
        generator(clients)
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts "tock in client"
        receiver()
    end
  end
end

