defmodule EctoJsonapi.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_jsonapi,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
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
      {:benchee, "~> 0.13", only: :dev},
      {:recase, "~> 0.4"}
    ]
  end
end
