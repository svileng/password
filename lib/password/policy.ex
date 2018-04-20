defmodule Password.Policy do
  @moduledoc """
  Behaviour for `Password` middleware policies.
  """

  @callback validate(input :: String.t(), config :: list) :: :ok | {:error, module}
end
