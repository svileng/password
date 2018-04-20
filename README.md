# Password

Elixir utility library with flexible password policies.

## Installation

Add to your `mix.exs`:

```elixir
def deps do
  [
    {:password, "~> 1.0"}
  ]
end
```

If you're not using [application inference](https://elixir-lang.org/blog/2017/01/05/elixir-v1-4-0-released/#application-inference), then add `:password` to your `applications` list.

## Usage

Create a new file and define a module like so:

```elixir
defmodule MyApp.Password do
  use Password, [
    # Policies
  ]

end
```

The empty list is where password policies go. For example:

```elixir
defmodule MyApp.Password do
  use Password, [
    {Password.Policy.SpecialCharacters}
  ]

end
```

To run the policies agains an input, use the `validate/1` function:

```elixir
iex> MyApp.Password.validate("password")
{:error, [Password.Policy.SpecialCharacters]}

iex> MyApp.Password.validate("password$")
:ok
```

To learn more about the included password policies and how to configure them,
see below.

## Password policies

Password's Policy modules are essentially middleware that you can plug
in or extend to create your own. At moment, the current modules are included:

- [Password.Policy.SpecialCharacters](https://hexdocs.pm/password/Password.Policy.SpecialCharacters.html) - verified input includes 1 (or more) special characters
- [Password.Policy.CommonPasswords](https://hexdocs.pm/password/Password.Policy.CommonPasswords.html) - verifies input is not one of the most common used passwords

Check documentation on [hexdocs](https://hexdocs.pm/password/api-reference.html)

To create your own password policies, simply create a module that implements the `Password.Policy` behaviour and provide the `validate/2` function. See source of included modules as an example.

## About

This project is sponsored by [Heresy](http://heresy.io). We're always looking for great engineers to join our team, so if you love Elixir, open source and enjoy some challenge, drop us a line and say hello!

## License

* Password: See LICENSE file.
* "Heresy" name and logo: Copyright © 2018 Heresy Software Ltd
