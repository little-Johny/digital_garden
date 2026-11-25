defmodule Servy do
  @moduledoc """
  Documentation for `Servy`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Servy.hello()
      :world

  """
  def hello(language) do
    "Hello, #{language}"
  end
end

IO.puts Servy.hello("elixir")
