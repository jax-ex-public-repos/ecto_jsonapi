word = "username_and_password"
# Macro.Camelize https://github.com/elixir-lang/elixir/blob/v1.8.1/lib/elixir/lib/macro.ex#L1469
# Recase.to_camel https://github.com/sobolevn/recase/blob/master/lib/recase/cases/camel_case.ex#L1

Benchee.run(
  %{
    "Macro.camelize" => fn -> Macro.camelize(word) end,
    "EctoJsonapi.Utilities.Camelcase.parse" => fn ->
      EctoJsonapi.Utilities.Camelcase.parse(word)
    end,
    "EctoJsonapi.Utilities.Camelcase.WithoutGuard.parse" => fn ->
      EctoJsonapi.Utilities.Camelcase.WithoutGuard.parse(word)
    end,
    "EctoJsonapi.Utilities.Camelcase.WithoutGuardOrString.parse" => fn ->
      EctoJsonapi.Utilities.Camelcase.WithoutGuardOrString.parse(word)
    end,
    "EctoJsonapi.Utilities.Camelcase.WithoutState.parse" => fn ->
      EctoJsonapi.Utilities.Camelcase.WithoutState.parse(word)
    end,
    "EctoJsonapi.Utilities.Camelcase.Optimized.parse" => fn ->
      EctoJsonapi.Utilities.Camelcase.Optimized.parse(word)
    end,
    "EctoJsonapi.Utilities.Camelcase.OptimizedTwo.parse" => fn ->
      EctoJsonapi.Utilities.Camelcase.OptimizedTwo.parse(word)
    end,
    "EctoJsonapi.Utilities.Camelcase.OptimizedThree.parse" => fn ->
      EctoJsonapi.Utilities.Camelcase.OptimizedThree.parse(word)
    end,
    "Recase.to_camel" => fn -> Recase.to_camel(word) end
  },
  time: 10,
  memory_time: 2
)
