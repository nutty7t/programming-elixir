defmodule AnimeTest do
  use ExUnit.Case
  doctest Anime

  import Anime.CLI, only: [
    parse_args: 1,
    sort_into_descending_order: 1
  ]

  import Anime.Formatter, only: [
    format: 2,
    get_column_width: 2,
    get_value_width: 1
  ]

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

  test "can get the length of numbers and strings" do
    assert get_value_width(123456) == 6
    assert get_value_width("hello") == 5
    assert get_value_width("ナッティ") == 4
  end

  test "column width is calculated correctly" do
    assert get_column_width(fake_anime_list(), "title") == 19
  end

  test "test formatter" do
    format(fake_anime_list(), ["title", "foobar"])
  end

  defp fake_anime_list() do
    [
      %{"title" => "Fullmetal Alchemist", "foobar" => "elixir"},
      %{"title" => "Code Geass", "foobar" => "functional"},
      %{"title" => "Dragon Ball Super", "foobar" => "erlang"},
      %{"title" => "Toradora", "foobar" => "programming"},
      %{"title" => "Naruto", "foobar" => "recursion"}
    ]
  end

  defp fake_start_date_list(values) do
    for value <- values,
    do: %{"watch_start_date" => value}
  end
end

