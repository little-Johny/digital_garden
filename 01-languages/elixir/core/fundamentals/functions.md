# Funciones

En Elixir, las funciones son **"ciudadanos de primera clase"** porque son tratadas exactamente igual que cualquier otro valor (como números o cadenas).

Esto implica capacidades fundamentales que son clave para la programación funcional:

- Asignación: Se pueden asignar a variables.
- Argumentos: Se pueden pasar como argumentos a otras funciones (base de los patrones de orden superior como map o filter).
- Retorno: Se pueden devolver como valor de retorno de otras funciones.

## Funciones Anónimas

Se definen utilizando las palabras clave `fn` y `end`. Se pueden asignar a variables y pasar como argumentos.

```elixir
sum = fn (a, b) -> a + b end
sum.(1, 2) # => 3
```

> **Nota Técnica:**
> Las funciones anónimas se invocan usando un punto `.` entre la variable y los paréntesis.

### Sintaxis Corta de Captura (`&`)

El operador de captura `&` permite crear funciones anónimas de forma concisa, reemplazando la sintaxis `fn -> end` por referencias posicionales a argumentos (`&1`, `&2`, etc.).

**Ejemplo Básico:**
```elixir
# Forma tradicional
sum = fn a, b -> a + b end

# Con operador de captura
sum = &(&1 + &2)
sum.(1, 2) # => 3
```

**Ejemplo Avanzado:**
Es especialmente útil para reducir verbosidad en funciones de orden superior.

```elixir
# Sin captura
sumar = fn lista -> Enum.reduce(lista, 0, fn x, acc -> x + acc end) end

# Con captura (la función interna usa &)
sumar = fn lista -> Enum.reduce(lista, 0, &(&1 + &2)) end
```

## Funciones Nombradas

Las funciones nombradas se definen dentro de módulos usando `def` para funciones públicas y `defp` para funciones privadas.

```elixir
defmodule Math do
  def sum(a, b) do
    a + b
  end

  defp private_helper do
    "Solo visible dentro de Math"
  end
end
```

### Convenciones de Nombres
- **`?`**: Se usa al final del nombre si la función retorna un booleano (ej. `even?`).
- **`!`**: Se usa si la función lanza una excepción en caso de error en lugar de retornar una tupla de error.

## Pattern Matching y Cláusulas

Elixir permite definir múltiples cláusulas para una misma función. Elixir intentará hacer "match" con los argumentos de arriba a abajo.

```elixir
defmodule Greeting do
  def hello(:spanish), do: "Hola"
  def hello(:english), do: "Hello"
  def hello(_), do: "Unknown language"
end
```

Si ninguna cláusula coincide, se lanza un `FunctionClauseError`.

## Guardas (Guards)

Las guardas refinan el pattern matching, permitiendo comprobaciones más complejas sobre los argumentos. Se definen con `when`.

```elixir
defmodule Math do
  def zero?(0), do: true
  def zero?(x) when is_integer(x), do: false
end
```

Las guardas tienen limitaciones; solo se pueden usar un conjunto reducido de expresiones (como comparaciones aritméticas y chequeos de tipo `is_*`).

## Argumentos por Defecto (Default Arguments)

Se pueden definir valores por defecto usando `\\`.

```elixir
defmodule Math do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

Math.join("Hola", "Mundo")      # => "Hola Mundo"
Math.join("Hola", "Mundo", "_") # => "Hola_Mundo"
```

### Cabeceras de Función (Function Headers)

Cuando una función tiene múltiples cláusulas y argumentos por defecto, se recomienda (y a veces se requiere) declarar los defaults en una cabecera de función vacía.

```elixir
defmodule Math do
  # Cabecera con defaults
  def sum(a, b \\ 0)

  # Implementaciones
  def sum(a, b) when is_integer(a) do
    a + b
  end
  
  def sum(a, b) when is_float(a) do
    a + b
  end
end
```

> [!WARNING]
> Los argumentos por defecto pueden causar conflictos si las cláusulas se superponen de manera ambigua.

## Operador Pipe (`|>`)

El operador pipe toma el resultado de la expresión a su izquierda e lo inserta como el **primer argumento** de la función a su derecha.

```elixir
string
|> String.trim()
|> String.upcase()
```

Esto equivale a `String.upcase(String.trim(string))`, pero es mucho más legible.

## Captura de Funciones Nombradas

Podemos "capturar" una función nombrada como si fuera anónima usando `&Modulo.funcion/aridad`.

```elixir
fun = &Math.sum/2
# Ahora fun se puede usar como una función anónima
# fun.(1, 2)
```