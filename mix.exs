defmodule Password.MixProject do
  use Mix.Project

  @version "1.1.0"

  def project do
    [
      app: :password,
      version: @version,
      elixir: "~> 1.3",
      name: "Password",
      description: "Flexible password policies.",
      package: [
        maintainers: ["Svilen Gospodinov <svilen@heresy.io>"],
        licenses: ["MIT"],
        links: %{Github: "https://github.com/heresydev/password"}
      ],
      docs: [
        main: "readme",
        extras: ["README.md"],
        source_url: "https://github.com/heresydev/password",
        source_ref: @version
      ],
      deps: deps()
    ]
  end

  def application() do
    []
  end

  defp deps() do
    [
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end
end
