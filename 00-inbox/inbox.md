# 📥 Inbox (Bandeja de Entrada)

> **Objetivo:** Capturar rápido sin preocuparse por el formato final.
> **Rutina:** Revisar este archivo al final del día/semana y mover el contenido a su carpeta correspondiente (ej. `01-languages`, `02-concepts`).

---

## 📅 Capturas de Hoy (2026-01-22)

### 💡 Introducción a Elixir (Lasagna Exercise)

**Contexto:** Traducción de conceptos básicos para el ejercicio de Lasagna.
**Tags:** #elixir #basics #functional-programming

#### Introducción

##### Conceptos Básicos

##### Variables

Elixir es un lenguaje de tipado dinámico (_dynamically-typed_), lo que significa que el tipo de una variable solo se verifica en tiempo de ejecución (_runtime_). Usando el operador de coincidencia (_match_) `=`, podemos vincular un valor de cualquier tipo a un nombre de variable:

```elixir
# Vincular un valor entero de 1
count = 1

# Puedes volver a vincular variables
count = 2

# Puedes volver a vincular cualquier tipo a una variable
count = false

# Los Strings pueden crearse encerrando caracteres entre comillas dobles
message = "Success!"
```

##### Módulos

Elixir es un lenguaje de programación funcional y requiere que todas las _named functions_ (funciones con nombre) se definan en un módulo. La palabra clave `defmodule` se usa para definir un módulo. Todos los módulos están disponibles para todos los demás módulos en tiempo de ejecución y no requieren un modificador de acceso para hacerlos visibles a otras partes del programa. Un módulo es análogo a una clase en otros lenguajes de programación.

```elixir
defmodule Calculator do
  # ...
end
```

##### Funciones con nombre (Named functions)

Las funciones con nombre deben definirse dentro de un módulo. La palabra clave `def` se usa para definir una función pública con nombre.
Cada función puede tener cero o más argumentos. El valor de la última expresión en una función siempre se retorna implícitamente.

```elixir
defmodule Calculator do
  def add(x, y) do
    x + y
  end
end
```

Invocar una función se hace especificando su módulo y nombre de función, y pasando argumentos para cada uno de los argumentos de la función.

```elixir
sum = Calculator.add(1, 2)
# => 3
```

La palabra clave `defp` puede usarse en lugar de `def` para definir una función privada. Las funciones privadas solo pueden usarse desde dentro del mismo módulo que las definió.
Cuando se invoca una función dentro del mismo módulo donde está definida, se puede omitir el nombre del módulo.
También puedes escribir funciones cortas usando una sintaxis de una sola línea (nota la coma `,` y los dos puntos `:` alrededor de la palabra clave `do`).

```elixir
defmodule Calculator do
  def subtract(x, y) do
    private_subtract(x, y)
  end

  defp private_subtract(x, y), do: x - y
end

difference = Calculator.subtract(7, 2)
# => 5

difference = Calculator.private_subtract(7, 2)
# => ** (UndefinedFunctionError) function Calculator.private_subtract/2 is undefined or private
#       Calculator.private_subtract(7, 2)
```

##### Aridad de funciones (Arity)

Es común referirse a las funciones por su aridad (_arity_). La aridad de una función es el número de argumentos que acepta.

```elixir
# add/3 porque esta función tiene tres argumentos, por lo tanto una aridad de 3
def add(x, y, z) do
  x + y + z
end
```

##### Convenciones de nomenclatura

Los nombres de los Módulos deben usar `PascalCase`. Un nombre de módulo debe comenzar con una letra mayúscula A-Z y puede contener letras a-zA-Z, números 0-9 y guiones bajos `_`.
Los nombres de variables y funciones deben usar `snake_case`. Un nombre de variable o función debe comenzar con una letra minúscula a-z o un guion bajo `_`, puede contener letras a-zA-Z, números 0-9 y guiones bajos `_`, y podría terminar con un signo de interrogación `?` o un signo de exclamación `!`.

##### Biblioteca estándar (Standard library)

Elixir tiene una biblioteca estándar muy rica y bien documentada. La documentación está disponible en línea en hexdocs.pm/elixir. Guarda este enlace en algún lugar, ¡lo usarás mucho!
La mayoría de los tipos de datos integrados (_built-in_) tienen un módulo correspondiente que ofrece funciones para trabajar con ese tipo de dato, por ejemplo, existe el módulo `Integer` para enteros, el módulo `String` para cadenas, el módulo `List` para listas, y así sucesivamente.
Un módulo notable es el módulo `Kernel`. Proporciona las capacidades básicas sobre las cuales se construye el resto de la biblioteca estándar, como operadores aritméticos, macros de control de flujo y mucho más.
Las funciones del módulo `Kernel` se importan automáticamente, por lo que puedes usarlas sin el prefijo `Kernel.`.

##### Comentarios de código

Los comentarios pueden usarse para dejar notas para otros desarrolladores que lean el código fuente. Los comentarios de una sola línea en Elixir están precedidos por `#`.

##### Instrucciones

En este ejercicio vas a escribir algo de código para ayudarte a cocinar una lasaña brillante de tu libro de cocina favorito.
Tienes cinco tareas, todas relacionadas con el tiempo dedicado a cocinar la lasaña.

---

## 📅 Capturas Anteriores (2025-11-30)

### 💡 [Título Breve del Concepto]

**Contexto:** (Curso, Video, Artículo, Pensamiento Random)
**Tags:** #elixir #pattern-matching

**Apuntes Rápidos:**

- Punto clave 1
- Punto clave 2
- [ ] Duda: ¿Cómo funciona esto con X?
      Prueba de commit

```elixir
# Pegar código sucio aquí
```

**Destino Probable:**

- [ ] Mover a `fundamentals/`
- [ ] Crear nueva nota en `concepts/`

---

## ⏳ Pendientes de Procesar (Días Anteriores)

---

## ✅ Historial / Procesado

(Opcional: Mueve aquí lo que ya clasificaste si te da miedo borrarlo, o simplemente bórralo)

- [x] Keyword Lists & Maps (Procesado 2025-11-30) -> `associative-data-structures.md`, `pattern-matching.md`
