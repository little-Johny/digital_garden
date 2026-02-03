# Progreso de Aprendizaje: Elixir

Seguimiento del progreso basado en la [guía de evaluación](../../06-resources/learning-evaluation-guide.md).

**Última actualización:** 2026-01-26

---

## Estado por Checkpoint

### Checkpoint 1: Fundamentos ✅ Completo
| Tema | Estado | Archivo |
|------|--------|---------|
| Modos de ejecución | ✅ | `core/fundamentals/execution-modes.md` |
| Tipos de datos | ✅ | `core/fundamentals/data-types.md` |
| Operadores | ✅ | `core/fundamentals/operators.md` |
| Pattern matching | ✅ | `core/fundamentals/pattern-matching.md` |
| Control de flujo | ✅ | `core/fundamentals/control-structures.md` |

**Evaluación:** Resolver ejercicios de Exercism que validen estos conceptos.

---

### Checkpoint 2: Composición ✅ Completo
| Tema | Estado | Archivo |
|------|--------|---------|
| Funciones | ✅ | `core/fundamentals/functions.md` |
| Módulos | ✅ | `core/fundamentals/modules.md` |
| Recursión | ✅ | `core/fundamentals/recursion.md` |
| Estructuras asociativas | ✅ | `core/fundamentals/associative-data-structures.md` |
| Enums/Streams/Pipe | ✅ | `core/fundamentals/enums.md` |

**Evaluación:** Implementar algoritmos con recursión pura (sin Enum).

---

### Checkpoint 3: Aplicación 🔄 En progreso
| Tema | Estado | Archivo |
|------|--------|---------|
| Procesos (básico) | ✅ | `core/fundamentals/processes.md` |
| Manejo de errores | ⬜ | - |
| I/O y archivos | ⬜ | - |
| Mix (proyectos) | ⬜ | - |
| Structs | ⬜ | - |
| Protocolos | ⬜ | - |

**Evaluación:** Crear proyecto con Mix que procese archivos reales.

---

### Checkpoint 4: Dominio ⬜ Pendiente
| Tema | Estado | Archivo |
|------|--------|---------|
| GenServer | ⬜ | - |
| Supervisores | ⬜ | - |
| OTP | ⬜ | - |
| Metaprogramación | ⬜ | - |
| Releases | ⬜ | - |

**Evaluación:** Construir aplicación con supervisión y tolerancia a fallos.

---

## Ejercicios Completados

### Exercism
| Ejercicio | Fecha | Conceptos |
|-----------|-------|-----------|
| hello-world | - | Módulos, funciones |
| lasagna | - | Funciones, aridad |
| pacman-rules | - | Booleanos, condicionales |

### Pendientes Recomendados
| Ejercicio | Evalúa | Prioridad |
|-----------|--------|-----------|
| `bob` | Pattern matching, condicionales | Alta |
| `roman-numerals` | Recursión, pattern matching | Alta |
| `list-ops` | Implementar map/filter/reduce manualmente | Alta |
| `accumulate` | Funciones anónimas, Enum | Media |
| `strain` | Filter sin usar Enum.filter | Media |

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

1. **Inmediato:** Resolver 3-5 ejercicios más en Exercism
2. **Esta semana:** Implementar sum/reverse/map con recursión pura
3. **Próximo:** Documentar manejo de errores y File I/O
4. **Después:** Crear mini-proyecto con Mix
