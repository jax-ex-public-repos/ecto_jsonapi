word = "foo_bar_biz_baz_buz_quxx_qaxx"

Benchee.run(
  %{
    "Macro.camelize" => Macro.camelize(word),
    "EctoJsonapi.Utilities.Camelcase.parse" => EctoJsonapi.Utilities.Camelcase.parse(word),
    "Recase.to_camel" => Recase.to_camel(word)
  },
  time: 10,
  memory_time: 2
)
