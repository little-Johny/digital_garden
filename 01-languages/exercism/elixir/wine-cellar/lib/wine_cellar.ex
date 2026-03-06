defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ []) do
    # Opción A: variables intermedias
    # Primero filtramos por color (get_values porque la clave puede repetirse)
    wines = Keyword.get_values(cellar, color)

    # Si opts trae :year, aplicamos el filtro; si no, dejamos la lista igual
    wines_by_year = case Keyword.get(opts, :year) do
      nil  -> wines
      year -> filter_by_year(wines, year)
    end

    # Igual con :country, encadenando sobre el resultado anterior
    wine_by_country = case Keyword.get(opts, :country) do
      nil     -> wines_by_year
      country -> filter_by_country(wines_by_year, country)
    end

    wine_by_country
  end

  # Opción B: pipeline con then/2 (equivalente a la opción A, más idiomático)
  # then/2 recibe un valor y una función, aplica la función y retorna el resultado.
  # Permite escribir lógica condicional inline sin romper la cadena de pipes.
  #
  # def filter(cellar, color, opts \\ []) do
  #   Keyword.get_values(cellar, color)
  #   |> then(fn wines ->
  #     case Keyword.get(opts, :year) do
  #       nil  -> wines
  #       year -> filter_by_year(wines, year)
  #     end
  #   end)
  #   |> then(fn wines ->
  #     case Keyword.get(opts, :country) do
  #       nil     -> wines
  #       country -> filter_by_country(wines, country)
  #     end
  #   end)
  # end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
