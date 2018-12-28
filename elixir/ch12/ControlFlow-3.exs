# Exercise: ControlFlow-3
# Chapter 12, Page 140

defmodule ControlFlow do
  def ok!({status, data}) do
    case status do
      :ok -> data
      :error -> raise "Error occurred: #{data} ☹️"
    end
  end
end

# Test Driver.
IO.inspect ControlFlow.ok!(File.open("ControlFlow-3.exs"))
IO.inspect ControlFlow.ok!(File.open("Maplestory.exe"))
