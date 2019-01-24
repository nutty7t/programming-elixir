defmodule Weather.Formatter do

  @moduledoc """
  Formats the current weather observation.
  """

  @doc """
  Nicely outputs the weather data.
  """
  def format_output(weather_data) do
    padding = compute_padding weather_data
    Enum.each(Map.to_list(weather_data), fn {k, v} ->
      IO.puts "#{String.pad_trailing(to_string(k), padding, " ")} : #{v}"
    end)
  end

  @doc """
  Takes a map and outputs the length of the longest key.
  """
  def compute_padding(weather_data) do
    weather_data
    |> Map.keys
    |> Enum.map(&length/1)
    |> Enum.max
  end
end
