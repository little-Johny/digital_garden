# Recursión

## 1. Introducción
**¿Qué es?**
La recursión en Elixir es una técnica en donde una función se llama a sí misma, con el objetivo de resolver problemas complejos dividiéndolos en versiones más pequeñas y manejables. Elixir utiliza el "pattern matching" (coincidencia de patrones) y guardas para definir casos base (finalización) y pasos recursivos. Esta técnica está optimizada gracias a TCO (*Tail Call Optimization*), evitando así un desbordamiento de pila (*Stack Overflow*), lo que la convierte en una forma idiomática y eficiente de crear bucles.

## 2. Conceptos Clave

- **TCO (Tail Call Optimization):** Es una optimización del compilador de Elixir que permite ejecutar funciones recursivas sin consumir espacio adicional en la pila de llamadas, evitando desbordamientos, siempre que la última acción de la función sea la propia llamada recursiva.

### Entendiendo TCO (Ejemplo Visual)

La diferencia clave radica en si queda alguna operación pendiente después de la llamada recursiva.

```elixir
# ❌ Sin TCO (Recursión de Pila)
# El sistema debe recordar cada paso porque hay una suma pendiente (head + ...)
def sumar([]), do: 0
def sumar([head | tail]) do
  head + sumar(tail) # <--- La suma ocurre DESPUÉS del retorno de la función
end

# ✅ Con TCO (Recursión de Cola)
# No hay nada pendiente. El acumulador lleva el resultado parcial.
def sumar(lista), do: sumar(lista, 0)
def sumar([], acc), do: acc
def sumar([head | tail], acc) do
  sumar(tail, acc + head) # <--- La llamada es lo ÚLTIMO que ocurre
end
```

## 3. Ejemplos de Código

### Sintaxis Básica
```elixir
# Ejemplo
# Una función que imprime un mensaje "n" cantidad de veces, llamándose a sí misma
# hasta que se haya cumplido con la cantidad de repeticiones requerida.

defmodule Recursion do
  def print_multiple_times(msg, n) when n > 0 do
    IO.puts("#{msg} #{n}")
    print_multiple_times(msg, n - 1)
  end

  def print_multiple_times(_msg, 0), do: :ok # Sintaxis corta para casos base

  def print_multiple_times(_msg, n) when n < 0 do
    IO.puts("""
    The second parameter must be greater than 0.
    Please try with a higher number.
    """)
  end
end

Recursion.print_multiple_times("Hello", 5)
## Resultado
# Hello 5
# Hello 4
# Hello 3
# Hello 2
# Hello 1

Recursion.print_multiple_times("Hello", 0)
## Resultado
# :ok

Recursion.print_multiple_times("Hello", -5)
## Resultado
# The second parameter must be greater than 0.
# Please try with a higher number.
# :ok
```

### Caso de Uso Real
```elixir
# Un ejemplo más aplicado a la realidad: Procesar un carrito de compras

defmodule Store do
  # 1. Función pública: El usuario solo pasa la lista de precios
  def collect_cart(price_list) do
    # Se inicia la recursión con el total en 0
    scan(price_list, 0)
  end

  # 2. Caso base: la cinta está vacía ([])
  # No hay nada más para sumar, se devuelve el total final
  defp scan([], total) do
    "Total: #{total}"
  end

  # 3. PASO RECURSIVO: Hay productos en la cinta ([current_price | rest_products])
  defp scan([current_price | rest_products], total_accumulate) do
    # Suma del precio actual con el total acumulado
    new_total = total_accumulate + current_price
    IO.puts("Escaneando el producto de $#{current_price}... (El total va en: $#{new_total})")

    # Se llama a sí misma con el resto de la lista y el nuevo total (TCO)
    scan(rest_products, new_total)
  end
end

Store.collect_cart([10, 20, 30])

## Resultado
# Escaneando el producto de $10... (El total va en: $10)
# Escaneando el producto de $20... (El total va en: $30)
# Escaneando el producto de $30... (El total va en: $60)
# "Total: 60"
```

## 4. Algoritmos Reduce y Map

### Reduce
- Al proceso de tomar una lista y reducirla a un único valor se le conoce como `reduce` y es un concepto fundamental en la programación funcional.

```elixir
# Buscamos crear una función que reciba una lista y devuelva la suma de sus elementos
defmodule Math do
  def sum_list(list, acc \\ 0) # Los valores por defecto se definen en la cabecera

  def sum_list([head | tail], acc) do
    sum_list(tail, head + acc)
  end

  def sum_list([], acc) do
    acc
  end
end

Math.sum_list([1, 2, 3])

# Explicación de ejecución paso a paso:
# 1. sum_list([1, 2, 3], 0)
# 2. sum_list([2, 3], 1)      # acc = 0 + 1 (head)
# 3. sum_list([3], 3)         # acc = 1 + 2 (head)
# 4. sum_list([], 6)          # acc = 3 + 3 (head)
# Resultado: 6
```

### Map
- Al proceso de tomar una lista y transformarla ejecutando una operación sobre cada elemento se le conoce como `map`.

```elixir
defmodule MathMap do
  # ... código anterior ...

  def double_each([head | tail]) do
    # NOTA: Esta implementación manual NO tiene Tail Call Optimization (TCO)
    # porque la última operación es la construcción de la lista (|),
    # no la llamada recursiva directa.
    [head * 2 | double_each(tail)]
  end

  # Ejemplo con Tail Call Optimization (TCO):
  def double_each_tco(list, acc \\ [])
  def double_each_tco([head | tail], acc), do: double_each_tco(tail, [head * 2 | acc])
  def double_each_tco([], acc), do: Enum.reverse(acc)

  def double_each([]) do
    []
  end
end
```

> **Nota:** Es importante saber que en Elixir no se suele usar la recursión manual de esta manera para tareas comunes. Módulos como `Enum` o `List` ya incluyen funciones optimizadas que usan recursión internamente.

```elixir
Enum.reduce([1, 2, 3], 0, fn x, acc -> x + acc end)
# Resultado: 6

Enum.map([1, 2, 3], fn x -> x * 2 end)
# Resultado: [2, 4, 6]
```

## 5. Buenas Prácticas (Do's & Don'ts)

- ✅ **Usar Acumuladores:** Para asegurar la optimización de llamada final (TCO), pasa el estado acumulado como argumento en la función recursiva.
- ✅ **Definir Casos Base Claros:** Asegúrate de que tus casos base (como una lista vacía `[]` o `0`) sean visibles y alcanzables para evitar bucles infinitos.
- ❌ **Evitar Recursión Manual Innecesaria:** Prefiere siempre las funciones del módulo `Enum` (`map`, `reduce`, `filter`, etc.) sobre la recursión manual, ya que son más legibles, estándar y están optimizadas.
- ⚠️ **Cuidado con la Construcción de Listas:** Recuerda que construir listas en la llamada de retorno (como `[h | recursive_call(t)]`) rompe la TCO; si necesitas rendimiento con listas grandes, usa construcción inversa con acumulador y luego invierte la lista, o usa `Enum.map`.

## 6. Relacionado
- [Enlace a otro tema del jardín digital](./otro-tema.md)

## 7. Referencias Externas
- [Documentación Oficial de Elixir](https://elixir-lang.org/docs.html)
- [Elixir School](https://elixirschool.com/)
