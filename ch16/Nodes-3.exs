# Exercise: Nodes-3
# Chapter 16, Page 226

defmodule Ticker do
  @interval 2000
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[], 0])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients, tick_number) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator([pid|clients], tick_number)
    after
      @interval ->
        IO.puts "tick"

        if clients != [] do
          index = rem tick_number, length(clients)
          client = Enum.at(clients, index)
          send client, {:tick}
        end

        generator(clients, tick_number + 1)
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

