defmodule EctoJsonapi.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_jsonapi,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      source_url: "http://github.com/mrmicahcooper/ecto_jsonapi",
      package: package(),
      ocs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.0"},
      {:jason, "~> 1.1", only: :test},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Micah Cooper"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/mrmicahcooper/ecto_jsonapi"}
    ]
  end

  defp docs do
    [
      extras: [
        "README.md"
      ]
    ]
  end
end
