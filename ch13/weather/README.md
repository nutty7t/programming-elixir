# Weather

> In the United States, the National Oceanic and Atmospheric Administration provides
> hourly XML feeds of conditions at 1,800 locations. Write an application that fetches
> that data, parses it, and displays it in a nice format.

``` bash
> mix run -e 'Weather.CLI.main(["KPHX"])'
location           : Phoenix, Phoenix Sky Harbor International Airport, AZ
observation_time   : Last Updated on Jan 27 2019, 8:51 pm MST
temperature_string : 60.0 F (15.6 C)
weather            : Fair
wind_string        : Calm
```

