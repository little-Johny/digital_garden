defmodule Recursion do
    def get_user_values() do
      message = IO.gets("Please enter you message ")
      {number, _} = Integer.parse(IO.gets("How many times do you want to print it? "))
      print_many_times(message, number)
    end

    defp print_many_times(msg, times) when times > 0 do
        IO.puts(msg)
        print_many_times(msg, times - 1)
    end

    defp print_many_times(_msg, 0) do
      IO.puts("Done")
    end
end
