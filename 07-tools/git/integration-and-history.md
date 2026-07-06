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
