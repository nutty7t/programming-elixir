defmodule Anime.AnimeList do

  require Logger

  @user_agent [ {"User-Agent", "Elixir <hello@nutty.cc>"} ]
  @anime_url Application.get_env(:anime, :anime_url)

  def fetch(username) do
    Logger.info("Fetching #{username}'s MyAnimeList profile")

    anime_url(username)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def anime_url(username) do
	"#{@anime_url}/user/#{username}/animelist/completed"
  end

  def handle_response({ :ok, %{status_code: status_code, body: body} }) do
    Logger.info("Got response: #{status_code}")
    Logger.debug(fn -> IO.inspect(body) end)
    {
      status_code |> check_for_error(),
      body        |> Poison.Parser.parse!()
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_),   do: :error
end

