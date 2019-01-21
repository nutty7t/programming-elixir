defmodule AnimeTest do
  use ExUnit.Case
  doctest Anime

  import Anime.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "foobar"]) == :help
    assert parse_args(["--help", "foobar"]) == :help
  end

  test "two values returned if two are given" do
    assert parse_args(["nutty7t", "32"]) == {"nutty7t", 32}
  end

  test "count is defaulted if one value is given" do
    assert parse_args(["nutty7t"]) == {"nutty7t", 10}
  end
end

