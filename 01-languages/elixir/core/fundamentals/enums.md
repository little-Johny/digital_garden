# 🔄 Enums y Colecciones

El módulo `Enum` es el caballo de batalla de Elixir. Dado que las listas y mapas son fundamentales, `Enum` proporciona las herramientas para iterar, transformar y filtrar estas colecciones.

## 1. Enum.map (Transformación)

Transforma cada elemento de una colección aplicando una función. Devuelve una nueva lista con los resultados.

```elixir
Enum.map([1, 2, 3], &(&1 * 2))
# [2, 4, 6]
```

### ⚠️ El "Gotcha" de los Mapas

Al iterar sobre un Mapa (`%{}`), `Enum` pasa cada elemento como una tupla `{key, value}`. Esto causa errores comunes con el operador de captura `&`.

```elixir
map = %{1 => 2, 3 => 4}

# ❌ Forma Incorrecta
# Enum.map(map, &(&1 * &2))
# Error: BadArityError. &(&1 * &2) espera 2 argumentos, pero Enum.map pasa 1 (la tupla).

# ✅ Forma Correcta (Pattern Matching) - Idiomática
Enum.map(map, fn {k, v} -> k * v end)

# ⚠️ Forma Correcta (Sin Pattern Matching) - No recomendada
# Accedemos a la tupla (&1) manualmente.
Enum.map(map, &(elem(&1, 0) * elem(&1, 1)))
```

---

## 2. Enum.reduce (Acumulación)

Reduce una colección a un único valor. Es la base de casi todas las operaciones de listas (sum, map, filter se pueden implementar con reduce).

```elixir
# Versión corta con operador de captura
Enum.reduce(1..3, &+/2)
# 6

# Versión explícita
Enum.reduce(1..3, 0, fn number, acc ->
  number + acc
end)
```

---

## 3. Listas (Operaciones Específicas)

Aunque usamos `Enum` para casi todo, el módulo `List` tiene operaciones específicas para la estructura de lista enlazada.

```elixir
List.insert_at([1, 2, 4], 2, 3)
# [1, 2, 3, 4]
```

> **Nota:** `insert_at` en una lista enlazada es una operación $O(n)$, ya que debe recorrer la lista hasta el índice.

---

## 4. Lazy vs Early Evaluation (Stream vs Enum)

Elixir tiene dos formas de procesar colecciones:

### Early Evaluation (Enum)

Evalúa **inmediatamente**. Cada paso del pipe crea una lista intermedia completa en memoria.

```elixir
odd? = &(rem(&1, 2) != 0)

# Esto recorre la lista completa y crea una nueva solo con los impares
Enum.filter(1..6, odd?)
```

### Lazy Evaluation (Stream)

No evalúa nada hasta que es estrictamente necesario (al final de la cadena, usualmente cuando llamas a un `Enum`). Útil para listas infinitas o muy grandes.

```elixir
1..1_000_000
|> Stream.map(&(&1 * 3)) # No hace nada aún
|> Stream.filter(odd?)   # Sigue sin hacer nada
|> Enum.sum()            # Aquí se dispara todo el proceso ("Greedy")
```

---

## 5. El Operador Pipe (`|>`)

Como un sistema Unix, el operador pipe toma el resultado de la expresión anterior y lo pasa como el **primer argumento** de la siguiente función.

```elixir
# Estilo anidado (Difícil de leer)
Enum.sum(Enum.filter(Enum.map(1..1_000_000, &(&1 * 3)), odd?))

# Estilo Pipe (Legible)
1..1_000_000
|> Enum.map(&(&1 * 3))
|> Enum.filter(odd?)
|> Enum.sum()
```
