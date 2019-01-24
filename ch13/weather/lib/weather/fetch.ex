defmodule Weather.Fetch do

  @moduledoc """
  Fetches and parses the XML feeds of current weather conditions for
  an observation location specified by an FAA location identifier.
  """

  import Weather.XML

  @api_endpoint "http://w1.weather.gov/xml/current_obs"
  @fields_to_fetch [
    'location',
    'observation_time',
    'weather',
    'temperature_string',
    'wind_string'
  ]

  @doc """
  Returns an API URL from an FAA location identifier.
  """
  def api_url(identifier) do
    "#{@api_endpoint}/#{identifier}.xml"
  end

  @doc """
  Returns an XPath query for a given element name.
  """
  def xpath_query(name) do
    '/current_observation/#{name}/text()'
  end

  @doc """
  Make a GET request to the National Oceanic and Atmospheric Administration.
  Return a map that neatly represents the parsed response body.
  """
  def fetch_weather_conditions(identifier) do
    case HTTPoison.get(api_url(identifier), [], follow_redirect: true) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        parse_weather_conditions(body)
      _ ->
        print_error_and_exit()
    end
  end

  @doc """
  Parse the XML response body.
  """
  def parse_weather_conditions(response_body) do
    Enum.reduce(@fields_to_fetch, %{}, fn field_name, acc ->
      field_value = parse_field(response_body, field_name)
      Map.put(acc, field_name, field_value)
    end)
  end

  @doc """
  Returns the value of the XML text node of the `field_name` element.
  """
  def parse_field(response_body, field_name) do
    :xmerl_xpath.string(
      xpath_query(field_name),
      from_string(response_body)
    )
    |> List.first
    |> xmlText(:value)
  end

  @doc """
  Something bad happened. Let's tell the user.
  """
  def print_error_and_exit() do
    IO.puts "error: failed to get weather conditions"
    System.halt(0)
  end
end
