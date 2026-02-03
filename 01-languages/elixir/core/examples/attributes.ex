defmodule Math do
  @moduledoc """
  Provides math-related functions.

  ## Examples

      iex> Math.sum(1, 2)
      3

  """

  @doc """
  Calculates the sum of two numbers.
  """

  def sum(a, b), do: a + b

end

# comment this :


# iex(4)>  defmodule MyServer do
#           @initial_state %{host: "127.0.0.1", port: 3456}
#           IO.inspect(@initial_state)
#        end
# %{port: 3456, host: "127.0.0.1"}
# {:module, MyServer,
# <<70, 79, 82, 49, 0, 0, 4, 160, 66, 69, 65, 77, 65, 116, 85, 56, 0, 0, 0, 166,
#   0, 0, 0, 16, 15, 69, 108, 105, 120, 105, 114, 46, 77, 121, 83, 101, 114, 118,
#   101, 114, 8, 95, 95, 105, 110, 102, 111, 95, 95, 10, 97, 116, 116, 114, 105,
#   98, 117, 116, 101, 115, 7, 99, 111, 109, 112, 105, 108, 101, 10, 100, 101,
#   112, 114, 101, 99, 97, 116, 101, 100, 11, 101, 120, 112, 111, 114, 116, 115,
#   95, 109, 100, 53, 9, 102, 117, 110, 99, 116, ...>>, ...}
# iex(5)> MyServer
# MyServer



# iex(6)> defmodule MyServer do
#          @my_data 14
#          def first_data, do: @my_data
#          @my_data 13
#          def second_data, do: @my_data
#        end
# warning: redefining module MyServer (current version defined in memory)
# └─ iex:6: MyServer (module)

# {:module, MyServer,
#  <<70, 79, 82, 49, 0, 0, 6, 44, 66, 69, 65, 77, 65, 116, 85, 56, 0, 0, 0, 189,
#    0, 0, 0, 18, 15, 69, 108, 105, 120, 105, 114, 46, 77, 121, 83, 101, 114, 118,
#    101, 114, 8, 95, 95, 105, 110, 102, 111, 95, 95, 10, 97, 116, 116, 114, 105,
#    98, 117, 116, 101, 115, 7, 99, 111, 109, 112, 105, 108, 101, 10, 100, 101,
#    112, 114, 101, 99, 97, 116, 101, 100, 11, 101, 120, 112, 111, 114, 116, 115,
#    95, 109, 100, 53, 9, 102, 117, 110, 99, 116, ...>>, ...}
# iex(7)> MyServer.second_data
# 13
# iex(8)> MyServer.first_data
# 14


# defmodule MyApp.Status do
#       @service URI.parse("http://example.com")
#       def status(email), do: SomeHTTPClient.get(@service)
#   end
#
# URI.parse("http://example.com")
# %URI{
#   scheme: "http",
#   authority: "example.com",
#   userinfo: nil,
#   host: "example.com",
#   port: 80,
#   path: nil,
#   query: nil,
#   fragment: nil
# }
##
