defmodule LengthTest do
  use ExUnit.Case
  alias Password.Policy.Length

  test "works with default settings" do
    assert {:error, _} = Length.validate("pass", [])
    assert :ok = Length.validate("password", [])
  end

  test "accepts min option" do
    assert {:error, _} = Length.validate("password", [min: 10])
    assert :ok == Length.validate("password10", [min: 10])
  end
end
