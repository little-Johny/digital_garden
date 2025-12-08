# Modules

En Elixir, los módulos son la mecanismo principal para organizar y namespacing el código. Son grupos de funciones, macros y structs relacionados.

## Definiendo un Módulo

Los módulos se definen usando el macro `defmodule/2`.

```elixir
defmodule Math do
  def sum(a, b) do
    a + b
  end
end
```

## Funciones

Dentro de un módulo, puedes definir funciones públicas con `def/2` y funciones privadas con `defp/2`.

```elixir
defmodule Math do
  def sum(a, b) do
    do_sum(a, b)
  end

  defp do_sum(a, b) do
    a + b
  end
end
```

- **Funciones públicas** (`def`): Pueden ser invocadas desde otros módulos.
- **Funciones privadas** (`defp`): Solo pueden ser invocadas dentro del módulo donde están definidas.

## Atributos de Módulo

Los atributos de módulo sirven para tres propósitos:
1.  **Anotaciones**: Como `@doc` y `@moduledoc` para documentación.
2.  **Constantes**: Almacenar valores para ser reutilizados.
3.  **Temporary storage**: Used during compilation.

```elixir
defmodule MyModule do
  @moduledoc "This is the module documentation."
  
  @my_constant 3.14

  @doc "Returns the constant."
  def get_constant, do: @my_constant
end
```

## Compilación

Los módulos de Elixir se compilan en archivos `.beam` (bytecode de Erlang). Esto generalmente ocurre automáticamente con herramientas como `mix`, pero también puedes compilar archivos manualmente usando `elixirc`.

## Directivas (Alias, Require, Import, Use)

Elixir proporciona directivas para facilitar el trabajo con módulos.

### `alias`
Permite referirse a un módulo por un nombre más corto.

```elixir
alias MyApp.Deeply.Nested.Module
# Ahora puedes usar Module en lugar del nombre completo
```

### `require`
Requerido para usar macros de otro módulo. Asegura que el módulo se compile antes de su uso.

```elixir
require Integer
Integer.is_odd(3)
```

### `import`
Importa funciones y macros de un módulo en el ámbito actual, para que puedas llamarlos sin el prefijo del módulo.

```elixir
import List, only: [last: 1]
last([1, 2, 3])
```

### `use`
Invoca el macro `__using__/1` del módulo especificado, permitiendo que el módulo inyecte código en el contexto actual.

```elixir
defmodule MyTest do
  use ExUnit.Case
end
```
