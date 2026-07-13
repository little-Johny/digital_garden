defmodule Manifiesto do
  def total(manifiest \\ []) do
    do_total(manifiest, 0)
  end

  defp do_total([], acc), do: acc

  defp do_total([{_, quantity} | tail], acc) do
    total = acc + quantity
    do_total(tail, total)
  end


  def invertir(list \\ []) do
    do_invertir(list, [])
  end

  defp do_invertir([], acc), do: acc
  defp do_invertir([head | tail], acc) do
    inverted_list = [head | acc]
    do_invertir(tail, inverted_list)
    #do_invertir(tail) ++ [head]
  end

end

# Count total of unities
# IO.inspect(Manifiesto.total([{"oxígeno", 4}, {"agua", 7}, {"raciones", 2}]))

# Revert list
IO.inspect(Manifiesto.invertir([1,2,3]))
