defmodule Username do

  def sanitize([]), do: ~c""

  def sanitize([head | tail]) do
    case head do
      char when char >= ?a and char <= ?z ->
        [char] ++ sanitize(tail)

      ?_ ->
        [?_] ++ sanitize(tail)

      ?ä ->
        ~c"ae" ++ sanitize(tail)

      ?ö ->
        ~c"oe" ++ sanitize(tail)

      ?ü ->
        ~c"ue" ++ sanitize(tail)

      ?ß ->
        ~c"ss" ++ sanitize(tail)

      _ ->
        sanitize(tail)
    end
  end
end
