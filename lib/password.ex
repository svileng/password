defmodule Password do
  @moduledoc """
  Elixir utility library with flexible password policies.

  See `README.md` for installation and usage instructions.
  """

  defmacro __using__(middleware \\ []) do
    quote bind_quoted: [middleware: middleware] do
      @middleware middleware

      @doc "Validates given input according to configured password policies."
      def validate(input) when is_binary(input) do
        results =
          Enum.map(@middleware, fn
            {module} ->
              apply(module, :validate, [input, []])

            {module, config} ->
              apply(module, :validate, [input, config])

            _ ->
              msg = "Config should be in the form of {module, config}."
              raise(ArgumentError, message: msg)
          end)

        if Enum.all?(results, &(&1 == :ok)) do
          :ok
        else
          results
          |> Enum.reject(fn res -> res == :ok end)
          |> Enum.reduce({:error, []}, fn {_, policy}, {_, failed_policies} ->
            {:error, failed_policies ++ [policy]}
          end)
        end
      end
    end
  end

  @doc false
  @spec path_to_file(String.t()) :: String.t()
  def path_to_file(filename) do
    priv_dir_path = to_string(:code.priv_dir(:password))
    Path.join([priv_dir_path, filename])
  end
end
