defmodule Password.Policy.CommonPasswords do
  @moduledoc """
  Check whether a password figures in the list of
  most common passwords by Mark Burnett (xato.net).

  To use, simply add it to the list of policies:

  ```elixir
  use Password, [
    {Password.Policy.CommonPasswords}
  ]
  ```

  ```elixir
  iex> MyApp.Password.validate("password")
  {:error, [Password.Policy.CommonPasswords]}

  iex> MyApp.Password.validate("very unusual password")
  :ok
  ```

  List contains only the top passwords with minimum
  length of 8 characters, so anything shorter won't
  produce matches and will pass.
  """
  @behaviour Password.Policy

  Password.path_to_file("top_10k_common_passwords.txt")
  |> File.stream!()
  |> Stream.map(&String.trim/1)
  |> Stream.reject(&match?("", &1))
  |> Enum.map(fn password ->
    def validate(unquote(password), _opts), do: {:error, __MODULE__}
  end)

  @impl Password.Policy
  def validate(input, _opts) do
    input_length = String.length(input)

    if input_length < 8 do
      :ok
    else
      file =
        if input_length in 8..10 do
          "common_passwords_#{input_length}.txt"
        else
          "common_passwords_11+.txt"
        end

      Password.path_to_file(file)
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Stream.reject(&match?("", &1))
      |> Stream.filter(&(String.length(&1) == input_length))
      |> Enum.find(&(&1 == input))
      |> case do
        true -> {:error, __MODULE__}
        nil -> :ok
      end
    end
  end
end
