defmodule Anime.CLI do

  @default_count 10

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a table
  of the last _n_ animes watched for a MyAnimeList user.
  """

  def run(argv) do
    argv
    |> parse_args
    |> process
    |> Anime.Formatter.format(["title", "total_episodes"])
    |> IO.inspect
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise, it is a MyAnimeList username.

  Return a tuple of `{ username, count }` or `:help` if help was given.
  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [ help: :boolean ],
                                     aliases: [ h: :help ])
    |> elem(1)
    |> args_to_internal_representation()
  end

  def args_to_internal_representation([ username, count ]) do
    { username, String.to_integer(count) }
  end

  def args_to_internal_representation([ username ]) do
    { username, @default_count }
  end

  def args_to_internal_representation(_) do
    :help
  end

  def process(:help) do
    IO.puts """
    usage:  anime <username> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def process({ username, count }) do
    Anime.AnimeList.fetch(username)
    |> decode_response
    |> sort_into_descending_order
    |> last(count)
  end

  def decode_response({:ok, body}), do: body["anime"]

  def decode_response({:error, error}) do
    IO.puts "Error fetching from MyAnimeList: #{error["message"]}"
    System.halt(2)
  end

  def sort_into_descending_order(anime_list) do
    anime_list
    |> Enum.sort(fn a1, a2 ->
      a1["watch_start_date"] >= a2["watch_start_date"]
    end)
  end

  def last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse
  end
end

