defmodule SpecialCharactersTest do
  use ExUnit.Case
  alias Password.Policy.SpecialCharacters

  test "works with default settings" do
    assert {:error, _} = SpecialCharacters.validate("password", [])
    assert :ok = SpecialCharacters.validate("password!", [])
  end

  test "accepts min option" do
    assert {:error, _} = SpecialCharacters.validate("password!", [min: 2])
    assert {:error, _} = SpecialCharacters.validate("password!!", [min: 2])
    assert :ok == SpecialCharacters.validate("password!@", [min: 2])
  end

  test "accepts chars options" do
    assert {:error, _} = SpecialCharacters.validate("password", [chars: ~w(@)])
    assert {:error, _} = SpecialCharacters.validate("password!", [chars: ~w(@)])
    assert :ok = SpecialCharacters.validate("password@", [chars: ~w(@)])
  end
end
