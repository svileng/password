defmodule Password.Policy.Length do
  @moduledoc """
  Checks whether input is of certain minimum length.

  By default, the minimum length is 8 characters, although we
  recommend increasing it higher.

  By design, you cannot set a maximum length — passwords should be
  hashed, so the maximum length shouldn't matter in technical terms.

  ```elixir
  use Password, [
    {Password.Policy.Length}
  ]
  ```

  ```elixir
  iex> MyApp.Password.validate("pass")
  {:error, [Password.Policy.Length]}

  iex> MyApp.Password.validate("password")
  :ok
  ```

  Increasing minimum length:

  ```elixir
  use Password, [
    {Password.Policy.Length, min: 10}
  ]
  ```

  ```elixir
  iex> MyApp.Password.validate("password")
  {:error, [Password.Policy.Length]}
  ```
  """
  @behaviour Password.Policy

  @default_min_length 8

  @impl Password.Policy
  def validate(input, opts) do
    min_chars = Keyword.get(opts, :min, @default_min_length)
    if String.length(input) >= min_chars, do: :ok, else: {:error, __MODULE__}
  end
end
