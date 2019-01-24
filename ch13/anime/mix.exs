defmodule Anime.MixProject do
  use Mix.Project

  def project do
    [
      app:             :anime,
      escript:         escript_config(),
      version:         "0.1.0",
      elixir:          "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps:            deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.4"},
      {:poison,    "~> 3.1"},
      {:ex_doc,    "~> 0.19", only: :dev, runtime: false},
      {:earmark,   "~> 1.3.0"}
    ]
  end
  defp escript_config do
	[
	  main_module: Anime.CLI
	]
  end
end

