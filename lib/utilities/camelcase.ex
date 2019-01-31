# Original Implementation
defmodule EctoJsonapi.Utilities.Camelcase do
  @word_delimiters ["", " ", "_", "-", "."]

  def parse(string),
    do: parse(string, "", nil)

  def parse("", acc, _state), do: acc

  def parse(<<h::binary-1, t::binary>>, acc, :upcase),
    do: parse(t, acc <> String.upcase(h), nil)

  def parse(<<h::binary-1, t::binary>>, "", _state) when h in @word_delimiters,
    do: parse(t, "", nil)

  def parse(<<h::binary-1, t::binary>>, acc, _state) when h in @word_delimiters,
    do: parse(t, acc, :upcase)

  def parse(<<h::binary-1, t::binary>>, "", _state),
    do: parse(t, String.downcase(h), nil)

  def parse(<<h::binary-1, t::binary>>, acc, _state),
    do: parse(t, acc <> h, nil)
end

# Tried to optimized without the `in` guard`
defmodule EctoJsonapi.Utilities.Camelcase.WithoutGuard do
  def parse(string),
    do: parse(string, "", nil)

  def parse("", acc, _state), do: acc

  def parse(<<h::binary-1, t::binary>>, acc, :upcase),
    do: parse(t, acc <> String.upcase(h), nil)

  def parse(" " <> t, acc, _state), do: parse(t, acc, :upcase)
  def parse("_" <> t, acc, _state), do: parse(t, acc, :upcase)
  def parse("." <> t, acc, _state), do: parse(t, acc, :upcase)
  def parse("-" <> t, acc, _state), do: parse(t, acc, :upcase)

  def parse(<<h::binary-1, t::binary>>, "", _state),
    do: parse(t, String.downcase(h), nil)

  def parse(<<h::binary-1, t::binary>>, acc, _state),
    do: parse(t, acc <> h, nil)
end

# Removed the `in` guard and the use of the `String.up/down case`
defmodule EctoJsonapi.Utilities.Camelcase.WithoutGuardOrString do
  def parse(string),
    do: parse(string, "", nil)

  def parse("", acc, _state), do: acc

  def parse(<<h::binary-1, t::binary>>, acc, :upcase),
    do: parse(t, acc <> upcase(h), nil)

  def parse(" " <> t, acc, _state), do: parse(t, acc, :upcase)
  def parse("_" <> t, acc, _state), do: parse(t, acc, :upcase)
  def parse("." <> t, acc, _state), do: parse(t, acc, :upcase)
  def parse("-" <> t, acc, _state), do: parse(t, acc, :upcase)

  def parse(<<h::binary-1, t::binary>>, "", _state),
    do: parse(t, downcase(h), nil)

  def parse(<<h::binary-1, t::binary>>, acc, _state),
    do: parse(t, acc <> h, nil)

  defp upcase(char) when char >= ?a and char <= ?z, do: char - 32
  defp upcase(char), do: char

  defp downcase(char) when char >= ?A and char <= ?Z, do: char + 32
  defp downcase(char), do: char
end

# Removed the use of state. handled the conversion with pattern matching
defmodule EctoJsonapi.Utilities.Camelcase.WithoutState do
  def parse(string), do: parse(string, "")

  def parse("", acc), do: acc

  def parse(<<?\s, h, t::binary>>, ""), do: parse(t, <<h>>)
  def parse(<<?_, h, t::binary>>, ""), do: parse(t, <<h>>)
  def parse(<<?., h, t::binary>>, ""), do: parse(t, <<h>>)
  def parse(<<?-, h, t::binary>>, ""), do: parse(t, <<h>>)

  def parse(<<?\s, h, t::binary>>, acc), do: parse(t, acc <> <<upcase(h)>>)
  def parse(<<?_, h, t::binary>>, acc), do: parse(t, acc <> <<upcase(h)>>)
  def parse(<<?., h, t::binary>>, acc), do: parse(t, acc <> <<upcase(h)>>)
  def parse(<<?-, h, t::binary>>, acc), do: parse(t, acc <> <<upcase(h)>>)

  def parse(<<h::binary-1, t::binary>>, ""),
    do: parse(t, downcase(h))

  def parse(<<h::binary-1, t::binary>>, acc),
    do: parse(t, acc <> h)

  defp upcase(char) when char >= ?a and char <= ?z, do: char - 32
  defp upcase(char), do: char

  defp downcase(char) when char >= ?A and char <= ?Z, do: char + 32
  defp downcase(char), do: char
end

# Ecto recommends "_". so let's optimize for that
# Also tried removing the "upcase/downcase" and making it as naive as possible
# this will only be used to camelize the keys of ecto structs
defmodule EctoJsonapi.Utilities.Camelcase.Optimized do
  def parse(string), do: parse(string, "")
  def parse("", acc), do: acc
  def parse(<<?_, h, t::binary>>, acc), do: parse(t, acc <> <<h - 32>>)
  def parse(<<h::binary-1, t::binary>>, acc), do: parse(t, acc <> h)
end

# Added the upcase function back in - it seemed faster
defmodule EctoJsonapi.Utilities.Camelcase.OptimizedTwo do
  def parse(string), do: parse(string, "")
  def parse("", acc), do: acc
  def parse(<<?_, h, t::binary>>, acc), do: parse(t, acc <> <<upcase(h)>>)
  def parse(<<h::binary-1, t::binary>>, acc), do: parse(t, acc <> h)

  defp upcase(char) when char >= ?a and char <= ?z, do: char - 32
  defp upcase(char), do: char
end

# Removed all unused functions. This seems to be the most performant and the
# most naive/brittle
defmodule EctoJsonapi.Utilities.Camelcase.OptimizedThree do
  def parse(string), do: parse(string, "")
  def parse("", acc), do: acc
  def parse(<<?_, h, t::binary>>, acc), do: parse(t, acc <> <<upcase(h)>>)
  def parse(<<h::binary-1, t::binary>>, acc), do: parse(t, acc <> h)

  defp upcase(char), do: char - 32
end
