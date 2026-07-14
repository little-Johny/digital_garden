# 🧩 Pattern Matching en Elixir

El operador `=` en Elixir no es una simple asignación (como en Java o JS), es un **operador de coincidencia** (Match Operator). Su trabajo es lograr que el lado izquierdo "encaje" con el derecho. Si no puede, lanza un error.

## 1. El Operador de Equivalencia

En Elixir, `x = 1` significa "haz que `x` coincida con `1`".

```elixir
x = 1 
# Output: 1
```

Como es una equivalencia matemática, podemos invertir el orden y sigue siendo válido siempre que los valores coincidan.

```elixir
1 = x
# Output: 1 (Verdadero, porque x vale 1)
```

Sin embargo, si intentamos igualar `x` (que vale 1) con `2`, obtenemos un **MatchError**.

```elixir
2 = x
# ** (MatchError) no match of right hand side value: 1
```

> **Nota:** Las variables solo pueden asignarse (binding) cuando están en el lado izquierdo. Si intentas usar una variable no definida en el lado derecho para asignar al izquierdo, fallará.
>
> ```elixir
> 1 = undefined
> # error: undefined variable "undefined"
> ```

-----

## 2. Descomposición de Estructuras

El superpoder del Pattern Matching es desestructurar datos complejos (Tuplas y Listas) en variables individuales.

### Tuplas

Podemos extraer valores posicionales. Aquí extraemos un átomo, un string y un booleano:

```elixir
{a, b, c} = {:moneda, "moneda", true}
IO.inspect(a) # :moneda
IO.inspect(b) # "moneda"
IO.inspect(c) # true
```

**Reglas de Coincidencia:**
Para que funcione, el lado izquierdo y el derecho deben tener el **mismo tipo** y el **mismo tamaño**.

  * ❌ **Error por tamaño diferente:** Intentar calzar 2 valores en 3 variables.
    ```elixir
    {a, b, c} = {"moneda", :moneda}
    # ** (MatchError) no match...
    ```
  * ❌ **Error por tipo diferente:** Intentar calzar una Lista en una Tupla.
    ```elixir
    {a, b, c} = [3, 3, 12]
    # ** (MatchError) no match...
    ```

### Tagged Tuples (Control de Flujo)

Es común usar átomos como "etiquetas" para verificar el éxito de una operación.

  * ✅ **Éxito:** El átomo `:ok` coincide en ambos lados, y extraemos `"success"` en la variable `result`.

    ```elixir
    {:ok, result} = {:ok, "success"}
    # result ahora vale "success"
    ```

  * ❌ **Fallo (MatchError):** Aquí el matching falla intencionalmente. Esperábamos `:ok` pero recibimos `:error`. Esto funciona como una aserción.

    ```elixir
    {:ok, resuls} = {:error, :oops} 
    # ** (MatchError) no match of right hand side value: {:error, :oops}
    ```

### Listas

Podemos extraer elementos exactos:

```elixir
[a, b, c] = [33, 1, 2]
# a = 33, b = 1, c = 2
```

#### Head & Tail (Cabeza y Cola)

Las listas en Elixir son enlazadas. Podemos separar el primer elemento (`head`) del resto de la lista (`tail`) usando el operador pipe `|`.

```elixir
[head | tail] = [1, 2, 3]

head # 1
tail # [2, 3]
```

> **Restricción:** No se puede extraer cabeza/cola de una lista vacía.
>
> ```elixir
> [first | other] = []
> # ** (MatchError) no match of right hand side value: []
> ```

#### Extracción Profunda (Deeply Nested)

Podemos combinar técnicas. En lugar de usar `Enum.at` (que es imperativo), podemos usar pattern matching para sacar el segundo elemento directamente:

```elixir
[first | rest] = [1000, :no, :yes, :book]

# Queremos el segundo elemento de 'rest' (:yes)
# Usamos _ para ignorar lo que no nos interesa
[_, segundo_elemento | _resto_final] = rest

IO.inspect(segundo_elemento) # :yes
```

#### Construcción de Listas

El operador `|` también sirve para agregar elementos al principio de una lista de forma eficiente.

```elixir
list = [1, 2, 3]
[0 | list] 
# Output: [0, 1, 2, 3]
```

-----

## 3. 🔄 Rebinding (Re-enlace)

Es la capacidad de reutilizar el nombre de una variable. En Elixir los datos son inmutables, así que no estamos "cambiando" el valor en memoria, estamos haciendo que la etiqueta `x` apunte a un nuevo lugar.

```elixir
x = 1  # x apunta a la memoria 0x01 (valor 1)
x = 2  # x ahora apunta a la memoria 0x02 (valor 2)
# El 1 sigue existiendo en memoria hasta que el Garbage Collector lo limpie.
```

-----

## 4. Pin Operator (`^`)

Por defecto, Elixir permite **re-asignar** variables (rebinding). Si queremos forzar una **comparación** con el valor existente de una variable en lugar de reasignarla, usamos el "Pin operator" (`^`).

Supongamos que `x` vale 1.

  * `x = 2` reasignaría `x` a 2.
  * `^x = 2` intenta comparar el valor *actual* de `x` (1) con 2.

<!-- end list -->

```elixir
x = 1
^x = 2
# ** (MatchError) no match of right hand side value: 2
```

**Uso dentro de estructuras:**
Podemos usarlo para asegurar que un elemento dentro de una lista o tupla coincida con una variable previa.

```elixir
# Verifica que el primer elemento sea igual a x (1)
[^x, 2, 3] = [1, 2, 3] 
# Éxito
```

```elixir
# Verifica que el segundo elemento sea igual a x (1)
{y, ^x} = {2, 1}
# Éxito: y toma el valor 2
```

### Wildcard (`_`)

Si hay un dato que **no nos interesa** y no queremos gastar memoria asignándolo a una variable, usamos el guion bajo `_`.

```elixir
# Solo me interesa el head, ignoro el resto
[head | _] = [1, 2, 3]
head # 1
```


-----

## 🏋️ Practicado en

- [guessing-game (#7)](../../exercism/guessing-game/README.md) — pattern matching y guards
- [kitchen-calculator (#9)](../../exercism/kitchen-calculator/README.md) — pattern matching en tuplas
- [manifiesto-kepler (proyecto)](../projects/manifiesto-kepler/README.md) — `[head | tail]` en cláusulas y desarme de tuplas en argumentos de `fn`
