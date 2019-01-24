defmodule Weather.CLI do

  @moduledoc """
  Parses an FAA location identifier from the command line arguments and
  uses it to fetch the current weather conditions for the corresponding
  airport, which is nicely formatted and outputted to `stdout`.
  """

  import Weather.Fetch
  import Weather.Formatter

  def main(argv) do
    argv
    |> parse_args
    |> fetch_weather_conditions
    |> format_output
  end

  @doc """
  `weather` only cares about the first positional argument; the FAA
  location identifier. All other positional arguments are ignored.
  """
  def parse_args(argv) do
    with {flags, args, _}  <- OptionParser.parse(argv, switches: [help: :boolean]),
         {:ok, identifier} <- validate_args(args, Keyword.get(flags, :help)),
         {:ok, identifier} <- normalize_args(identifier)
    do
      identifier
    else
      _ -> print_help_and_exit()
    end
  end

  @doc """
  Validates the command line arguments. Returns the first positional
  argument. If no valid positional arguments were passed or if the `--help`
  flag was passed, then the application will exit.
  """
  def validate_args(_, true) do
    print_help_and_exit()
  end

  def validate_args([identifier | _], _) do
    cond do
      Regex.match?(~r/^[A-Z0-9]{3,5}$/i, identifier) -> {:ok, identifier}
      true                                           -> {:error, identifier}
    end
  end

  @doc """
  Uppercase the identifier.
  """
  def normalize_args(identifier) do
    {:ok, String.upcase identifier}
  end

  @doc """
  Print command usage and exit.
  """
  def print_help_and_exit() do
    IO.puts "usage:  weather <location-identifier>"
    System.halt(0)
  end
end
