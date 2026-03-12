# CLAUDE.md — Digital Garden

## Idioma
Responde siempre en español.

## Estructura del proyecto

```
/
├── 00-inbox/          # Notas rápidas pendientes
├── 01-languages/
│   ├── <lang>/
│   │   ├── core/      # Apuntes de fundamentos del lenguaje
│   │   └── progress.md
│   └── exercism/
│       └── <lang>/    # Ejercicios de Exercism (uno por carpeta)
├── 02-concepts/       # Teoria agnóstica al lenguaje
├── 03-architecture/   # Patrones, diseño de sistemas
├── 04-devops/         # Docker, CI/CD, infraestructura
├── 05-projects/       # Snippets, PoCs
├── 06-resources/      # Bibliografía, templates, recursos
└── 07-tools/          # Herramientas agnósticas (Claude Code, etc.)
```

### Apuntes de Elixir

Los apuntes están en `01-languages/elixir/core/`. Explorar esa carpeta para encontrar el archivo relevante según el concepto a revisar.

## Convenciones de commits

Formato: `tipo: descripcion en español`

Tipos usados:
- `feat:` — solución de ejercicio o nueva funcionalidad
- `docs:` — apuntes, documentación
- `chore:` — tareas de mantenimiento

Ejemplos reales del proyecto:
- `feat: Add Elixir Exercism #16 exercise 'Name Badge' with initial files`
- `feat: Resolve Name Badge exercism #16`
- `docs: Add Charlists and Bitwise operators documentation to Elixir core fundamentals`

Siempre pedir confirmación antes de hacer un commit.

## Workflow: Exercism

### Comando: "nuevo ejercicio `<lenguaje>/<nombre>`"

1. Leer `01-languages/exercism/<lenguaje>/<nombre>/README.md`
2. Identificar los conceptos nuevos que introduce el ejercicio
3. Revisar los archivos de apuntes relevantes en `01-languages/<lenguaje>/` y determinar si ya están documentados o si hay que complementarlos
4. Explicar los conceptos nuevos al usuario (sin resolver el ejercicio)
5. Explicar el contexto narrativo del ejercicio: el escenario o historia que plantea (ej. "estás en un laboratorio y...", incluyendo convenciones o tablas relevantes)
6. Explicar qué pide el ejercicio, tarea por tarea
7. Hacer el commit inicial: `feat: Add <lenguaje> Exercism #N exercise '<Nombre>' with initial files`

### Comando: "finalizar ejercicio" (o "hacer commit")

1. Leer el archivo de solución actual
2. Verificar que compila y no tiene errores evidentes
3. Hacer el commit: `feat: Resolve <Nombre> exercism #N`

## Reglas para ejercicios de Exercism

- **Nunca dar la solución directamente.**
- Si el usuario pide revisión del progreso, señalar solo lo que falta o lo que puede mejorar, en forma de pistas o recomendaciones ("te recomiendo tener en cuenta...").
- Si el usuario pide explícitamente ver una solución alternativa (ej. "muéstrame cómo se haría con if"), se puede mostrar pero aclarando que es solo a modo ilustrativo.
