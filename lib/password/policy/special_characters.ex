defmodule Password.Policy.SpecialCharacters do
  @moduledoc """
  Checks whether input contains special characters.

  By default, it uses a built-in list of characters (see module's source), but you can provide your own:

  ```elixir
  use Password, [
    {Password.Policy.SpecialCharacters, chars: ~w(! @ #)}
  ]
  ```

  ```elixir
  iex> MyApp.Password.validate("password$")
  {:error, [Password.Policy.SpecialCharacters]}

  iex> MyApp.Password.validate("password#")
  :ok
  ```

  By default, at least 1 character from the list is required. To change this,
  use the `min` option:

  ```elixir
  use Password, [
    {Password.Policy.SpecialCharacters, min: 2, chars: ~w(! @ #)}
  ]
  ```

  ```elixir
  iex> MyApp.Password.validate("password!")
  {:error, [Password.Policy.SpecialCharacters]}

  iex> MyApp.Password.validate("password!@")
  :ok
  ```
  """
  @behaviour Password.Policy

  @default_min_chars 1
  @default_chars [
    " ",
    "~",
    "'",
    "\"",
    "[",
    "]",
    "{",
    "}",
    "(",
    ")",
    "<",
    ">",
    "!",
    "?",
    "#",
    "$",
    "%",
    "^",
    "&",
    "*",
    "-",
    "+",
    "=",
    ".",
    ":",
    ";",
    ",",
    "/",
    "\\",
    "@",
    "`",
    "§",
    "±",
    "|",
    "_",
    "—",
    "µ",
    "ø",
    "≤",
    "≥",
    "÷",
    "œ",
    "∑",
    "®",
    "π",
    "ß",
    "©",
    "Ω",
    "≈",
    "√"
  ]

  @impl Password.Policy
  def validate(input, opts) do
    chars = Keyword.get(opts, :chars, @default_chars)
    min_chars = Keyword.get(opts, :min, @default_min_chars)

    result =
      if min_chars == 1 do
        String.contains?(input, chars)
      else
        count =
          Enum.count(chars, fn char ->
            String.contains?(input, char)
          end)

        count >= min_chars
      end

    if result, do: :ok, else: {:error, __MODULE__}
  end
end
