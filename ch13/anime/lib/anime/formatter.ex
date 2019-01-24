defmodule Anime.Formatter do
  @horizontal_divider  "-"
  @vertical_divider   " | "
  @cross_divider      "-+-"

  def format(anime_list, headers) do
    [
      format_header(anime_list, headers),
      format_divider(anime_list, headers),
      format_rows(anime_list, headers)
    ]
    |> Enum.join("\n")
    |> IO.puts
  end

  def format_header(anime_list, headers) do
    for header <- headers do
      width = get_column_width(anime_list, header)
      String.pad_trailing(header, width)
    end
    |> Enum.join(@vertical_divider)
  end

  def format_divider(anime_list, headers) do
    for header <- headers do
      width = get_column_width(anime_list, header)
      String.duplicate(@horizontal_divider, width)
    end
    |> Enum.join(@cross_divider)
  end

  def format_rows(anime_list, headers) do
    for anime <- anime_list do
      for header <- headers do
        width = get_column_width(anime_list, header)
        String.pad_trailing(anime[header] |> to_string, width)
      end
      |> Enum.join(@vertical_divider)
    end
    |> Enum.join("\n")
  end

  def get_column_width(anime_list, header) do
    [header | (for anime <- anime_list, do: Map.get(anime, header))]
    |> Enum.map(&get_value_width/1)
    |> Enum.max
  end

  def get_value_width(value) do
    value |> to_string |> String.length
  end
end

