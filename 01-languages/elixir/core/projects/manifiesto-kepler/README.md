# Manifiesto Kepler

## Historia

Eres el oficial de carga de la estación orbital **Kepler-7**. Una tormenta solar
corrompió parte del sistema de a bordo y, entre las bajas, está el módulo `Enum`
de la computadora central. El manifiesto de carga —la lista que registra qué
suministros hay y en qué cantidad— quedó sin las operaciones básicas para
consultarlo.

Control de Misión necesita que reconstruyas esas operaciones desde cero,
usando solo lo esencial: **recursión y pattern matching**. Hasta que la nave de
reabastecimiento llegue con el parche, está prohibido usar `Enum`, `Stream`,
el módulo `List` o comprensiones (`for`). Solo tú, la cabeza y la cola de las
listas.

El manifiesto es una lista de tuplas `{nombre, cantidad}`:

```elixir
[{"oxígeno", 4}, {"agua", 7}, {"raciones", 2}]
```

## Tareas

Implementa el módulo `Manifiesto` en un archivo `manifiesto.exs`.

### 1. Contar el total de unidades

Control de Misión necesita saber cuántas unidades hay a bordo en total.
Implementa `Manifiesto.total/1`, que recibe el manifiesto y suma las cantidades.

```elixir
Manifiesto.total([{"oxígeno", 4}, {"agua", 7}, {"raciones", 2}])
# => 13

Manifiesto.total([])
# => 0
```

### 2. Invertir el orden de descarga

La carga se descarga en orden inverso al que se estibó (lo último que entró
sale primero). Implementa `Manifiesto.invertir/1`, que retorna la lista en
orden inverso.

```elixir
Manifiesto.invertir([{"oxígeno", 4}, {"agua", 7}, {"raciones", 2}])
# => [{"raciones", 2}, {"agua", 7}, {"oxígeno", 4}]
```

### 3. Transformar cada ítem

Los técnicos necesitan aplicar transformaciones arbitrarias a cada entrada del
manifiesto (etiquetar, duplicar cantidades para el simulacro, etc.). Implementa
`Manifiesto.mapear/2`, que recibe una lista y una función, y retorna una nueva
lista con la función aplicada a cada elemento.

```elixir
Manifiesto.mapear([1, 2, 3], fn x -> x * 2 end)
# => [2, 4, 6]

Manifiesto.mapear([{"agua", 7}], fn {nombre, cant} -> {nombre, cant + 1} end)
# => [{"agua", 8}]
```

### 4. Filtrar suministros

Hay que detectar qué suministros quedan disponibles. Implementa
`Manifiesto.filtrar/2`, que recibe una lista y una función predicado, y retorna
solo los elementos para los que el predicado retorna `true`.

```elixir
Manifiesto.filtrar([{"oxígeno", 4}, {"agua", 0}, {"raciones", 2}], fn {_n, c} -> c > 0 end)
# => [{"oxígeno", 4}, {"raciones", 2}]
```

### 5. La operación maestra

Los ingenieros sospechan que casi todo lo anterior es un caso particular de una
sola operación general. Implementa `Manifiesto.reducir/3`, que recibe una
lista, un valor inicial y una función combinadora `fn elemento, acumulador -> ... end`,
y "pliega" la lista en un solo valor.

```elixir
Manifiesto.reducir([1, 2, 3], 0, fn x, acc -> x + acc end)
# => 6

Manifiesto.reducir(["a", "b", "c"], "", fn letra, acc -> acc <> letra end)
# => "abc"
```

### 6. Bonus: demostrar la sospecha

Reescribe `total/1` e `invertir/1` para que internamente usen tu `reducir/3`
en lugar de recursión propia. Si tu `reducir/3` está bien hecho, cada una debe
quedar en una sola línea de cuerpo.

## Reglas

- Prohibido usar `Enum`, `Stream`, `List` y comprensiones `for`.
- Todo con funciones recursivas propias y pattern matching sobre `[cabeza | cola]`.
- El archivo debe poder ejecutarse con `elixir manifiesto.exs`. Agrega al final
  llamadas con `IO.inspect/1` para verificar cada tarea.

## Conceptos que practica

- [Recursión](../../fundamentals/recursion.md) — caso base, caso recursivo, acumuladores
- [Pattern matching](../../fundamentals/pattern-matching.md) — descomposición `[cabeza | cola]` y tuplas
- [Funciones](../../fundamentals/functions.md) — funciones anónimas como argumento

## Ejercicios relacionados

- [bird-count](../../../exercism/bird-count/README.md) — recursión sobre listas
- [dna-encoding](../../../exercism/dna-encoding/README.md) — recursión de cola con acumulador
- [language-list](../../../exercism/language-list/README.md) — operaciones básicas sobre listas

## Criterios de terminado

- [x] `total/1` suma las cantidades y retorna `0` para la lista vacía
- [x] `invertir/1` retorna la lista en orden inverso
- [x] `mapear/2` aplica la función a cada elemento sin alterar el orden
- [x] `filtrar/2` conserva solo los elementos que cumplen el predicado
- [x] `reducir/3` pliega la lista combinando con el valor inicial
- [ ] Bonus: `total/1` e `invertir/1` reescritas sobre `reducir/3`
- [ ] `elixir manifiesto.exs` corre sin errores y muestra los resultados esperados
- [ ] Ni una sola llamada a `Enum`, `Stream`, `List` ni `for`
