defmodule Manifiesto do
  def total(manifiest \\ []) do
    #do_total(manifiest, 0)
    
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


  def mapear(list, action) do
    do_mapear(list, action, [])
  end

  defp do_mapear([], _action, acc), do: invertir(acc)
  defp do_mapear([head | tail], action, acc) do
    altered_list = [action.(head) | acc]
    do_mapear(tail, action ,altered_list)
  end


  def filtrar(manifiest, predicado) do
    do_filtrar(manifiest, predicado, [])
  end

  defp do_filtrar([], _predicado, acc), do: invertir(acc)
  defp do_filtrar([head | tail], predicado, acc) do
    have_available? = predicado.(head)

    result = if have_available? do
      [head | acc]
    else
      acc
    end

    do_filtrar(tail, predicado, result)
  end


  def reducir(manifiest, initial_state, combiner) do
    do_reducir(manifiest, initial_state, combiner)
  end

  defp do_reducir([], state, _combiner), do: state
  defp do_reducir([head | tail], state, combiner) do
    new_state = combiner.(head, state)
    do_reducir(tail, new_state, combiner)
  end
end

# Count total of unities
# IO.inspect(Manifiesto.total([{"oxígeno", 4}, {"agua", 7}, {"raciones", 2}]))

# Revert list
#IO.inspect(Manifiesto.invertir([1,2,3]))

#Alter list
#IO.inspect(Manifiesto.mapear([1,2,3], fn x -> x * 2  end))

#Filter
#IO.inspect(Manifiesto.filtrar([{"oxígeno", 0}, {"agua", 7}, {"raciones", 2}], fn {_, x} -> x > 0  end))

IO.inspect(Manifiesto.reducir(["W","HA","A","T"], "", fn letter, acc  -> acc <> letter  end))
