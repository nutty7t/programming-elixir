defmodule AnimeTest do
  use ExUnit.Case
  doctest Anime

  import Anime.CLI, only: [ parse_args: 1,
                            sort_into_descending_order: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    # After refactoring to use args_to_internal_representation/1, this
    # option only works if there are no positional arguments.
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
  end

  test "two values returned if two are given" do
    assert parse_args(["nutty7t", "32"]) == {"nutty7t", 32}
  end

  test "count is defaulted if one value is given" do
    assert parse_args(["nutty7t"]) == {"nutty7t", 10}
  end

  test "sort descending orders the correct way" do
    result = sort_into_descending_order(fake_start_date_list(["c", "a", "b"]))
    anime_list = for anime <- result, do: Map.get(anime, "watch_start_date")
    assert anime_list == ~w{ c b a }
  end

  defp fake_start_date_list(values) do
    for value <- values,
    do: %{"watch_start_date" => value}
  end
end

