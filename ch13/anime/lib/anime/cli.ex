defmodule Anime.CLI do

  @default_count 10

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a table
  of the last _n_ animes watched for a MyAnimeList user.
  """

  def run(argv) do
    parse_args(argv)
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise, it is a MyAnimeList username.

  Return a tuple of `{ username, count }` or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
                                     aliases: [ h: :help ])

    case parse do
      { [ help: true ], _, _ }      -> :help
      { _, [ username, count ], _ } -> { username, String.to_integer(count) }
      { _, [ username ], _ }        -> { username, @default_count }
      _                             -> :help
    end
  end
end

