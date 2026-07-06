# Progreso de Aprendizaje: Elixir

Seguimiento del progreso basado en la [guía de evaluación](../../06-resources/learning-evaluation-guide.md).

**Última actualización:** 2026-07-06

---

## Estado por Checkpoint

### Checkpoint 1: Fundamentos ✅ Completo

| Tema               | Estado | Archivo                                   |
| ------------------ | ------ | ----------------------------------------- |
| Modos de ejecución | ✅     | `core/fundamentals/execution-modes.md`    |
| Tipos de datos     | ✅     | `core/fundamentals/data-types.md`         |
| Operadores         | ✅     | `core/fundamentals/operators.md`          |
| Pattern matching   | ✅     | `core/fundamentals/pattern-matching.md`   |
| Control de flujo   | ✅     | `core/fundamentals/control-structures.md` |

**Evaluación:** Resolver ejercicios de Exercism que validen estos conceptos.

---

### Checkpoint 2: Composición ✅ Completo

| Tema               | Estado | Archivo                                            |
| ------------------ | ------ | -------------------------------------------------- |
| Funciones          | ✅     | `core/fundamentals/functions.md`                   |
| Módulos            | ✅     | `core/fundamentals/modules.md`                     |
| Recursión          | ✅     | `core/fundamentals/recursion.md`                   |
| Estructuras        | ✅     | `core/fundamentals/associative-data-structures.md` |
| Enums/Streams/Pipe | ✅     | `core/fundamentals/enums.md`                       |

**Evaluación:** Implementar algoritmos con recursión pura (sin Enum).

---

### Checkpoint 3: Aplicación 🔄 En progreso

| Tema              | Estado | Archivo                             |
| ----------------- | ------ | ----------------------------------- |
| Procesos (básico) | ✅     | `core/fundamentals/processes.md`    |
| I/O y archivos    | ✅     | `core/fundamentals/io-file-path.md` |
| Fechas y tiempo   | ✅     | `core/fundamentals/dates-time.md`   |
| Manejo de errores | ⬜     | -                                   |
| Mix (proyectos)   | ⬜     | -                                   |
| Structs           | ⬜     | -                                   |
| Protocolos        | ⬜     | -                                   |

**Evaluación:** Crear proyecto con Mix que procese archivos reales.

> ⚠️ Nota: el proyecto `core/projects/hangman/` fue clonado como referencia, no resuelto.
> Sus conceptos (structs, tests, GenServer, protocols) NO cuentan como practicados.

---

### Checkpoint 4: Dominio ⬜ Pendiente

| Tema             | Estado | Archivo |
| ---------------- | ------ | ------- |
| GenServer        | ⬜     | -       |
| Supervisores     | ⬜     | -       |
| OTP              | ⬜     | -       |
| Metaprogramación | ⬜     | -       |
| Releases         | ⬜     | -       |

**Evaluación:** Construir aplicación con supervisión y tolerancia a fallos.

---

## Ejercicios Completados

### Exercism (en `exercism/`)

| #   | Ejercicio               | Conceptos                                |
| --- | ----------------------- | ---------------------------------------- |
| 1   | hello-world             | Módulos, funciones                       |
| 2   | lasagna                 | Funciones, aridad                        |
| 3   | pacman-rules            | Booleanos, condicionales                 |
| 4   | secrets                 | Funciones anónimas, Bitwise              |
| 5   | log-level               | Atoms, cond, argumentos por defecto      |
| 6   | language-list           | Listas                                   |
| 7   | guessing-game           | Pattern matching, guards                 |
| 9   | kitchen-calculator      | Tuplas, pattern matching                 |
| 11  | bird-count              | Recursión, listas                        |
| 12  | high-score              | Maps, atributos de módulo                |
| 13  | city-office             | Documentación, typespecs                 |
| 14  | german-sysadmin         | Charlists, case                          |
| 15  | rpg-character-sheet     | IO (puts/gets/inspect)                   |
| 16  | name-badge              | nil, if                                  |
| 17  | take-a-number           | Procesos, send/receive                   |
| 18  | wine-cellar             | Keyword lists                            |
| 19  | paint-by-number         | Bitstrings                               |
| 20  | dna-encoding            | Recursión de cola, bitstrings            |
| 21  | library-fees            | NaiveDateTime, fechas                    |

### Incompletos

| #   | Ejercicio               | Estado                                          |
| --- | ----------------------- | ----------------------------------------------- |
| 10  | high-school-sweetheart  | ⚠️ Parcial: falta implementar `pair/2`          |
| 22  | basketball-website      | 🔄 En curso (descargado, sin resolver)          |

### Pendientes Recomendados

| Ejercicio        | Evalúa                                    | Prioridad |
| ---------------- | ----------------------------------------- | --------- |
| `bob`            | Pattern matching, condicionales           | Alta      |
| `roman-numerals` | Recursión, pattern matching               | Alta      |
| `list-ops`       | Implementar map/filter/reduce manualmente | Alta      |
| `accumulate`     | Funciones anónimas, Enum                  | Media     |
| `strain`         | Filter sin usar Enum.filter               | Media     |

---

## Retos de Auto-evaluación

### Checkpoint 1-2: Recursión Pura

Implementar sin usar Enum:

- [ ] `sum/1` - Sumar elementos de una lista
- [ ] `reverse/1` - Invertir una lista
- [ ] `my_map/2` - Implementar map
- [ ] `my_filter/2` - Implementar filter
- [ ] `my_reduce/3` - Implementar reduce

### Checkpoint 3: Proyecto Práctico

- [ ] Crear proyecto con `mix new`
- [ ] Leer archivo CSV con `File.stream!`
- [ ] Procesar datos con Stream/Enum
- [ ] Manejar errores con `{:ok, _}` / `{:error, _}`
- [ ] Escribir resultado a archivo

### Checkpoint 4: Concurrencia

- [ ] Implementar GenServer básico
- [ ] Crear árbol de supervisión
- [ ] Manejar fallos con "let it crash"

---

## Próximos Pasos

1. **Inmediato:** Terminar `basketball-website` (#22) y completar `pair/2` de `high-school-sweetheart` (#10)
2. **Práctica:** Usar el skill `/practicar` — retos de recursión pura y caza de bugs
3. **Próximo:** Documentar manejo de errores y practicar Structs (sesión de práctica, no Hangman)
4. **Después:** Crear mini-proyecto con Mix
