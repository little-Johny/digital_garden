# Estructuras de Datos Asociativas

En Elixir, estas estructuras nos permiten asociar una **Clave (Key)** con un **Valor (Value)**. Las dos principales son las **Keyword Lists** y los **Maps**. Aunque parecen similares, tienen arquitecturas internas y casos de uso muy diferentes.

-----

## 1. Keyword Lists (Listas de Palabras Clave)

Técnicamente, **no son una estructura nueva**. Son simplemente una **lista de tuplas** con dos reglas específicas:

1.  El primer elemento de la tupla (la clave) **siempre es un átomo**.
2.  Son listas ordenadas (mantienen el orden de inserción).

### Concepto: Syntactic Sugar

"Azúcar Sintáctico" se refiere a una sintaxis diseñada para ser más fácil de leer o escribir, aunque por debajo se convierta en código más complejo.

  * **Realidad:** Es una lista de tuplas `[{:trim, true}, {:lines, 2}]`.
  * **Sugar:** Elixir te deja escribirlo así: `[trim: true, lines: 2]`.

```elixir
# Ambas son idénticas para la máquina
[{:trim, true}] == [trim: true] # true
```

### Casos de Uso y Características

**1. El patrón de "Opciones" en Funciones**
Se usan principalmente para pasar argumentos opcionales a funciones.

  * **Regla de Oro:** Si la Keyword List es el **último argumento** de una función, puedes omitir los corchetes `[]`.

```elixir
# Con corchetes (Sintaxis estricta)
String.split("1 2", " ", [trim: true])

# Sin corchetes (Lo habitual)
String.split("1 2", " ", trim: true)
```

**2. Flexibilidad de Claves (Ecto DSL)**
A diferencia de un Map, una Keyword List **puede tener claves repetidas**.
La librería **Ecto** (para Bases de Datos) aprovecha esto y el "syntactic sugar" para crear su **DSL** (Domain Specific Language).

> **Deep Dive: Ecto y DSL**
> Un DSL es un "mini-lenguaje" para un fin específico. Ecto permite escribir consultas que parecen SQL:
>
> ```elixir
> query = from w in Weather,
>   where: w.prcp > 0,   # Clave :where
>   where: w.temp < 20,  # Clave :where (¡Repetida!)
>   select: w            # Clave :select
> ```
>
> **El truco:** No es magia, es una Keyword List gigante pasada a la macro `from`. Al permitir claves repetidas, puedes acumular filtros `where` sin sobrescribirlos.

**3. Acceso y Performance**

  * **Acceso:** `lista[:clave]`. Si la clave está repetida, **solo devuelve el primer valor encontrado**.
  * **Limitación:** Al ser listas enlazadas, buscar un elemento es lento ($O(n)$) en listas largas.

-----

## 2. Maps (Mapas)

Es la estructura asociativa "real" y de propósito general (Key-Value Store).

  * **Sintaxis:** `%{:clave => valor}` o `%{clave: valor}` (si la clave es átomo).

### Características Principales

1.  **Cualquier tipo de dato como clave:** No estás limitado a átomos.
    ```elixir
    %{ 1 => "uno", "dos" => :two, :tres => 3 }
    ```
2.  **Sin orden:** No garantizan mantener el orden de inserción.
3.  **Acceso:**
      * `map[:clave]` -> Devuelve `nil` si no existe (seguro).
      * `map.clave` -> Solo funciona si la clave es un **átomo**. Falla si no existe.

### Pattern Matching en Maps (Explicación Profunda)

El matching en mapas funciona por **Subconjuntos**.

> **La Regla:** El patrón (lado izquierdo) coincide siempre que **todas sus claves existan en el mapa** (lado derecho) y los valores coincidan. No importa si el mapa tiene datos extra.

  * **Coincide (Subset):** El mapa tiene `:a` y `:b`, el patrón solo pide `:a`.
    ```elixir
    %{:a => x} = %{:a => 1, :b => 2}
    # x vale 1
    ```
  * **Falla (Missing Key):** El patrón pide `:c`, pero el mapa no la tiene.
    ```elixir
    %{:c => x} = %{:a => 1}
    # MatchError
    ```
  * **Empty Map:** Un mapa vacío `{}` en el patrón coincide con **cualquier** mapa (porque no exige ninguna clave).
    ```elixir
    %{} = %{cualquier: "cosa"}
    ```

### Variables como Claves (Pin Operator `^`)

Por defecto, las claves en el patrón son literales. Si quieres usar el valor de una variable como clave para buscar, usa el **Pin Operator**.

```elixir
n = 1
# Busca la clave 1 (valor de n) dentro del mapa
%{^n => valor} = %{1 => :one, 2 => :two}
# valor es :one
```

### Módulo Map y Actualización

Elixir provee el módulo `Map` para manipulaciones.

  * `Map.get(map, key)`: Obtiene valor.
  * `Map.put(map, key, val)`: Inserta o actualiza (seguro, sirve para cualquier mapa).
  * **Sintaxis de Actualización (`%{ map | ... }`):**
    Solo sirve para **actualizar claves que YA existen**. Si intentas añadir una clave nueva con esta sintaxis, fallará.
    ```elixir
    map = %{name: "Jhon"}
    %{map | name: "Mike"} # OK
    %{map | age: 30}      # Error (KeyError)
    ```

-----

## 3. Conceptos Extra

### Structs (La tercera estructura)

*(Mención honorífica)*
Son **Maps con esteroides**. Tienen claves predefinidas (como una clase) y proporcionan validación de estructura en tiempo de compilación. Se definen con `defstruct`. Son menos flexibles que los maps normales pero más seguros.

-----

##  Resumen Comparativo

| Característica | Keyword Lists (`[...]`) | Maps (`%{...}`) |
| :--- | :--- | :--- |
| **Claves** | Solo Átomos | Cualquier tipo |
| **Orden** | Ordenadas | Sin orden garantizado |
| **Duplicados** | ✅ Sí (Permite claves repetidas) | ❌ No (La última gana) |
| **Pattern Match** | Exacto (difícil de usar) | Subset (muy potente) |
| **Performance** | Lento en listas grandes ($O(n)$) | Rápido ($O(log n)$ o mejor) |
| **Uso Principal** | Opciones de funciones, Ecto | Estructura de datos general |
