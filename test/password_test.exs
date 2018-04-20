defmodule PasswordTest do
  use ExUnit.Case
  Code.compiler_options(ignore_module_conflict: true)

  test "accepts multiple policies" do
    defmodule PW do
      use Password, [
        {Password.Policy.SpecialCharacters},
        {Password.Policy.CommonPasswords}
      ]
    end

    {:error, policies} = PW.validate("password")
    assert length(policies) == 2
  end

  test "accepts policies with configs" do
    defmodule PW do
      use Password, [
        {Password.Policy.SpecialCharacters, min: 2},
      ]
    end

    {:error, policies} = PW.validate("password!")
    assert length(policies) == 1


    assert PW.validate("password!@") == :ok
  end
end
