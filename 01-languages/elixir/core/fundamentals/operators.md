# Operadores

## 1. Operadores Booleanos

Elixir tiene dos conjuntos de operadores booleanos:

### Estrictos (`and`, `or`, `not`)
El primer argumento **debe** ser un booleano (`true` o `false`). Si no, lanza un error.

```elixir
true and true   # true
true or false   # true
not false       # true
# 1 and true    # ❌ Error: Argument error
```

### Laxos / Simples (`&&`, `||`, `!`)
Aceptan cualquier tipo de dato. Todo valor es considerado "verdadero" (truthy) excepto `false` y `nil`.

```elixir
1 || true       # 1
false && 5      # false
!true           # false
nil && 13       # nil
```

## 2. Cortocircuitos (Short-circuiting)

Significa que **Elixir deja de evaluar** la expresión tan pronto como sabe el resultado final. Esto es vital para **eficiencia** (no hacer trabajo extra) y **seguridad** (evitar errores).

- `||` (OR): Busca el **primer verdadero**. Si el primero es `true`, ya no mira el segundo.
- `&&` (AND): Busca el **primer falso**. Si el primero es `false`, ya no mira el segundo.

```elixir
# Ejemplo de Eficiencia:
# Si 'cache' tiene datos, la función 'consultar_base_de_datos()' NUNCA se ejecuta.
datos = cache || consultar_base_de_datos()

# Ejemplo de Seguridad:
# Si 'usuario' es nil, no intentamos acceder a 'usuario.nombre' (lo que daría error).
usuario && usuario.nombre
```

## 3. Concatenación

### Strings (`<>`)
```elixir
"Hola " <> "Mundo" # "Hola Mundo"
```

### Listas (`++`, `--`)
```elixir
[1, 2] ++ [3, 4] # [1, 2, 3, 4]
[1, 2, 3] -- [2] # [1, 3]
```

## 4. Comparación y Orden de Tipos

A diferencia de otros lenguajes que lanzan error si comparas peras con manzanas (ej. `1 < "hola"`), Elixir permite comparar **cualquier tipo de dato** con otro.

**¿Por qué? (Pragmatismo)**
El objetivo es poder ordenar listas que contienen datos mixtos sin que el algoritmo de ordenamiento falle (crash).

**Orden de clasificación (de menor a mayor):**
Si tienes una bolsa mezclada, Elixir la ordenará siguiendo esta jerarquía:

`number < atom < reference < function < port < pid < tuple < map < list < bitstring`

```elixir
# Un número siempre es "menor" que un átomo
1 < :atom        # true

# Un átomo siempre es "menor" que un string (bitstring)
:ok < "hola"     # true
```

## 5. El Operador Pipe (`|>`)
Es el operador más emblemático de Elixir. Pasa el resultado de la expresión a la izquierda como el **primer argumento** de la función a la derecha.

```elixir
# Sin Pipe (Difícil de leer)
String.upcase(String.trim("  elixir  "))

# Con Pipe (Claro y secuencial)
"  elixir  "
|> String.trim()
|> String.upcase()
```