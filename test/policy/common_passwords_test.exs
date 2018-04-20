defmodule CommonPasswordsTest do
  use ExUnit.Case
  alias Password.Policy.CommonPasswords

  test "detects common passwords" do
    assert {:error, _} = CommonPasswords.validate("password", [])
    assert {:error, _} = CommonPasswords.validate("qwerty123456", [])
    assert :ok == CommonPasswords.validate("very unusual password", [])
  end
end
