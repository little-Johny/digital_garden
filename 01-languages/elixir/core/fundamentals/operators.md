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

## 6. Operadores Bitwise (Bit a Bit)

Elixir provee el módulo `Bitwise` para manipular datos a nivel de bits. Estas operaciones trabajan directamente sobre la representación binaria de los enteros.

### Importar el módulo

```elixir
import Bitwise

# Ahora puedes usar las funciones directamente
band(9, 3)  # => 1
```

### Operaciones disponibles

| Operador    | Función      | Descripción                          | Ejemplo                    |
| :---------- | :----------- | :----------------------------------- | :------------------------- |
| `&&&`       | `band/2`     | AND: 1 solo si ambos bits son 1     | `band(0b1010, 0b1100)` → `0b1000` (8) |
| `\|\|\|`    | `bor/2`      | OR: 1 si al menos un bit es 1       | `bor(0b1010, 0b1100)` → `0b1110` (14) |
| `^^^`       | `bxor/2`     | XOR: 1 solo si los bits son distintos| `bxor(0b1010, 0b1100)` → `0b0110` (6) |
| `<<<`       | `bsl/2`      | Shift Left: desplaza bits a la izq   | `bsl(1, 3)` → `0b1000` (8) |
| `>>>`       | `bsr/2`      | Shift Right: desplaza bits a la der  | `bsr(8, 2)` → `0b10` (2)  |
| `~~~`       | `bnot/1`     | NOT: invierte todos los bits         | `bnot(0b1010)` → `-11`    |

### Ejemplo práctico: Closures con Bitwise

Un patrón común es combinar operaciones bitwise con anonymous functions para crear pipelines de transformación:

```elixir
import Bitwise

# Crear funciones que "capturan" un secreto
secret_and = fn secret ->
  fn value -> band(value, secret) end
end

secret_xor = fn secret ->
  fn value -> bxor(value, secret) end
end

# Componer operaciones
mask = secret_and.(0b1111)
scramble = secret_xor.(0b1010)

42 |> mask.() |> scramble.()
# => 0
```

### ¿Cuándo usarlos?

- **Máscaras de bits**: Verificar/establecer flags individuales en un entero.
- **Protocolos de red**: Parsear headers y campos de bits.
- **Criptografía básica**: Operaciones XOR para cifrado simple.
- **Optimización**: Multiplicar/dividir por potencias de 2 con shifts.

-----

## 🏋️ Practicado en

- [pacman-rules (#3)](../../exercism/pacman-rules/) — operadores booleanos
- [secrets (#4)](../../exercism/secrets/README.md) — operadores Bitwise
