defmodule EctoJsonapi.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_jsonapi,
      description: "Use Ecto for JsonApi documents. Simply",
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      package: package()
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
      {:jason, "~> 1.1", only: :test}
    ]
  end

  defp package do
    [
      name: "ecto_jsonapi",
      maintainers: ["Micah Cooper"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mrmicahcooper/ecto_jsonapi"}
    ]
  end
end
