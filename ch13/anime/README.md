# Anime

This is a little toy project that was built while reading through *Chapter 13:
Organizing a Project*. It's a command line application that will display the last
$n$ animes that a MyAnimeList user has watched. Made using Jikan -- the unofficial
MyAnimeList REST API.

## Development

The other day, I learned about a really cool command that can let you run arbitrary
commands when files change -- `entr`. Eventually, it might be useful to create a
`Makefile` with a bunch of `.PHONY` targets with a bunch of different commands
including the following one:

```bash
# Run tests whenever an Elixir file is modified.
rg -l . | grep ex | entr mix test

# Run the Anime.CLI.run function.
mix run -e 'Anime.CLI.run(["nuttywhal", "3"])'
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `anime` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:anime, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/anime](https://hexdocs.pm/anime).

