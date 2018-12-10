# Exercise: ModulesAndFunctions-7
# Chapter 6, Page 70

# Convert a float to a string with two decimal digits. (Erlang)
:io_lib.format("~.2f", [3.14159])

# Get the value of an operating-system environment variable. (Elixir)
System.get_env("PATH")

# Return the extension component of a file name. (Elixir)
Path.extname("ModulesAndFunctions-7.exs")

# Return the process's current working directory. (Elixir)
System.cwd()

# Convert a string containing JSON into Elixir data structures.
# > https://github.com/devinus/poison can do this.

# Execute a command in your operating system's shell.
System.cmd("cat", ["ModulesAndFunctions-7.exs"])
