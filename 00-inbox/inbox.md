# 📥 Inbox (Bandeja de Entrada)

> **Objetivo:** Capturar rápido sin preocuparse por el formato final.
> **Rutina:** Revisar este archivo al final del día/semana y mover el contenido a su carpeta correspondiente (ej. `01-languages`, `02-concepts`).

---

## 📅 Capturas de Hoy

# 🛠️ Git: Comandos de Integración y Visualización

Este documento resume el funcionamiento de alias de integración limpia y visualización avanzada del historial.

---

## 🚀 1. Integración Limpia: `gm --ff-only`

Este comando suele ser un alias de `git merge --ff-only <rama>`. Su objetivo es integrar cambios sin alterar la estructura lineal del historial.

### Componentes:

- **`--ff-only` (Fast-Forward Only):** Solo permite la unión si la rama actual puede "saltar" directamente a la punta de la rama fuente.
- **Resultado:** Si hay éxito, el historial se mantiene como una línea recta. Si hay commits locales que no existen en la rama fuente, el proceso se aborta.

> **⚠️ Nota:** Evita la creación automática de "Merge commits", manteniendo el historial impecable.

---

## 🗺️ 2. Mapa del Historial: `git log --graph`

Comando diseñado para visualizar la estructura del repositorio de forma compacta y gráfica.

`git log master --graph --decorate --oneline`

### Desglose de banderas:

| Bandera      | Función                                                           |
| :----------- | :---------------------------------------------------------------- |
| `master`     | Apunta el historial específicamente a la rama principal.          |
| `--graph`    | Dibuja líneas ASCII a la izquierda para mostrar ramas y fusiones. |
| `--decorate` | Muestra etiquetas (`tags`) y punteros de rama (`HEAD`, `origin`). |
| `--oneline`  | Reduce cada commit a una sola línea (Hash corto + Mensaje).       |

---

## 💡 Tips de Productividad

Para no escribir estos comandos largos cada vez, puedes configurar **Alias** en tu terminal:

```bash
# Crear el alias 'tree' para visualizar el historial
git config --global alias.tree "log --graph --decorate --oneline"

# Uso:
git tree
```

---

# 🔢 Elixir: Bits y Composición

## Manipulación de Bits

El módulo `Bitwise` permite operaciones a nivel de bit. Es común importarlo para usar los operadores infijos.

```elixir
import Bitwise

# Operadores infijos comunes:
# &&& (AND)
# ||| (OR)
# <<< (Left Shift)
# >>> (Right Shift)
```

## Combinación de Funciones

Elixir favorece el uso del operador **Pipe** (`|>`) para encadenar transformaciones de datos, lo que equivale a la composición de funciones matemática $(f \circ g)(x)$.

```elixir
# Estilo Pipe (Lectura de izquierda a derecha)
dato |> funcion_g() |> funcion_f()

# Equivalente tradicional (más difícil de leer anidado)
funcion_f(funcion_g(dato))
```

---

## ⏳ Pendientes de Procesar (Días Anteriores)

---

## ✅ Historial / Procesado

(Opcional: Mueve aquí lo que ya clasificaste si te da miedo borrarlo, o simplemente bórralo)

- [x] Introducción a Elixir (Lasagna Exercise) (Procesado 2026-01-26) -> `01-languages/elixir/core/fundamentals/basics.md`
- [x] Keyword Lists & Maps (Procesado 2025-11-30) -> `associative-data-structures.md`, `pattern-matching.md`
