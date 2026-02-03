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

Elixir proporciona directivas para facilitar el trabajo con módulos. Es importante entender visualmente cuándo usar cuál:

- **`alias`**: "Llamaré a este módulo de forma corta". (Seguro y recomendado).
- **`import`**: "Trae las funciones aquí para usarlas sin prefijo". (Usar con precaución).
- **`require`**: "Necesito las macros de este módulo para compilar".

### 1. `alias`

Permite referirse a un módulo por un nombre más corto.

```elixir
alias MyApp.Deeply.Nested.Module
# Era: MyApp.Deeply.Nested.Module.func()
# Ahora: Module.func()

# Con renombrado explícito:
alias MyApp.Utils.Math.Geometry, as: Geo
Geo.calculate()

# Alias Implícito:
# Si no usas `as:`, el alias toma la última parte del nombre:
alias Math.List # Se convierte en `List`
```

> ⚠️ **Error Común:** `alias` espera un módulo (átomo en tiempo de compilación), no el resultado de una función.
>
> ```elixir
> alias Math.list # Error: invalid argument for alias
> ```

### 2. `require` y los Macros

¿Por qué existe `require`?
Un **Macro** no es una función; es una plantilla de código. Cuando usas un macro, Elixir **no llama** a una función, sino que _copia y pega_ el código del macro en tu archivo durante la compilación.

- **Razón del require:** Como el macro "inyecta" código, Elixir necesita asegurarse de que el módulo que define el macro esté cargado y disponible antes de seguir compilando.

```elixir
require Integer

# Integer.is_odd/1 es un macro.
# Se compila a algo como: (3 rem 2) != 0
Integer.is_odd(3)
```

> ⚠️ **Error Común:** Si olvidas `require Integer`, obtendrás un `UndefinedFunctionError` aunque el módulo parezca existir, porque los macros no se importan automáticamente.

### 3. `import`

Importa funciones y macros al ámbito actual.

```elixir
import List, only: [last: 1]
last([1, 2, 3]) # Funciona sin poner "List."
```

#### Alcance Léxico (Lexical Scope)

Las directivas solo viven dentro de las "paredes" (`do ... end`) donde las invocas.

```elixir
defmodule Prueba do
  def funcion_a do
    import List, only: [first: 1]
    first([1, 2, 3]) # ✅ Funciona aquí
  end

  def funcion_b do
    # first([1, 2, 3]) # ❌ Error: el import murió en funcion_a
  end
end
```

### 4. `use`

Invoca el macro `__using__/1` del módulo especificado. Es la forma más potente (y mágica), permitiendo que el módulo inyecte código, funciones, alias o requires en tu contexto.

```elixir
defmodule MyTest do
  use ExUnit.Case # Inyecta toda la maquinaria de testing de ExUnit
end
```

### 5. Multi-Directivas

Cuando una aplicación crece, es común necesitar varios módulos de un mismo espacio de nombres. Elixir permite agruparlos usando llaves `{}` para reducir el ruido visual.

```elixir
# En lugar de:
# alias MyApp.Services.User
# alias MyApp.Services.Order

alias MyApp.Services.{User, Order, Product}

# También funciona con require e import:
require MyApp.Macros.{Logger, Debugger}
import MyApp.Helpers.{StringHelper, DateHelper}, only: [format: 1]
```

## Organización y Anidamiento

### Anidamiento de Módulos

Puedes definir un módulo dentro de otro, lo que genera un nombre compuesto unido por puntos.

```elixir
defmodule Parent do
  defmodule Child do
    def hello, do: "Hola desde el hijo"
  end
end

# Invocación:
Parent.Child.hello()
```

### Extracción y Alias (Recomendado)

Para mejorar la mantenibilidad y evitar identación excesiva, es común definir los módulos por separado y usar `alias` para simular el anidamiento lógico.

```elixir
defmodule Foo.Bar do
  def sum(a, b), do: a + b
end

defmodule Foo do
  alias Foo.Bar # Permite usar "Bar" dentro de Foo

  def execute do
    Bar.sum(1, 2)
  end
end
```

## Detalles Internos (Módulos == Átomos)

Elixir corre sobre la máquina virtual de Erlang (BEAM). Una revelación importante es que **los módulos en Elixir son simplemente Átomos**.

- Cuando escribes `String`, es en realidad un alias para el átomo `:"Elixir.String"`.

```elixir
is_atom(String)             # true
to_string(String)           # "Elixir.String"
:"Elixir.String" == String  # true
```

### Interoperabilidad con Erlang

Dado que los módulos son átomos, puedes llamar a cualquier librería estándar de Erlang usando su nombre como átomo (los módulos de Erlang suelen estar en minúsculas).

```elixir
# Erlang: os:system_time()
:os.system_time()

# Erlang: lists:flatten()
:lists.flatten([1, [2, 3], 4]) # [1, 2, 3, 4]

# Esto es equivalente a llamar al módulo Elixir por su nombre completo de átomo:
:"Elixir.List".flatten([1, [2], 3])
```
