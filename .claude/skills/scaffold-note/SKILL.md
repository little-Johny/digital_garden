---
name: scaffold-note
description: Crear un nuevo apunte (archivo .md) en el digital garden siguiendo las convenciones del proyecto. Decide la ubicación correcta dentro de la estructura (01-languages, 02-concepts, 03-architecture, 04-devops, 05-projects, 07-tools, 00-inbox), elige un template apropiado de 06-resources/templates/ si aplica, o se basa en el formato de los archivos vecinos del directorio destino cuando no hay template directo. Invocar cuando el usuario pida "crear apunte", "nuevo apunte sobre X", "scaffold note", "documentar Y", "agregar nota sobre Z", o solicite añadir documentación a alguna sección del jardín digital.
---

# scaffold-note

Genera un nuevo apunte en el digital garden respetando idioma, ubicación, y formato del proyecto.

## Reglas globales

- **Idioma:** todo el contenido del apunte se escribe en español.
- **Nombre del archivo:** kebab-case y descriptivo (`pattern-matching.md`, `genservers.md`, `dependency-injection.md`).
- **No sobrescribir:** si el archivo ya existe, detenerse y avisar al usuario.
- **No hacer commit automático.** Después de crear el archivo, avisar al usuario y proponer el mensaje de commit en formato `docs: ...` solo cuando lo confirme.

## Paso 1 — Identificar tema y ubicación

Mapear la solicitud a la carpeta correcta:

| Tipo de apunte | Carpeta destino |
|---|---|
| Fundamento de un lenguaje | `01-languages/<lang>/core/fundamentals/` |
| Otro contenido de `core` (no fundamental) | `01-languages/<lang>/core/` o subcarpeta existente |
| Ecosistema / tooling de un lenguaje | `01-languages/<lang>/ecosystem/` |
| Proyecto práctico de un lenguaje | `01-languages/<lang>/projects/` |
| Concepto agnóstico al lenguaje | `02-concepts/` |
| Patrón o diseño de sistemas | `03-architecture/` |
| Docker, CI/CD, infraestructura | `04-devops/` |
| Snippet o PoC | `05-projects/` |
| Herramienta agnóstica (Claude Code, Git, etc.) | `07-tools/` |
| No clasificable todavía | `00-inbox/` |

Antes de crear el archivo:

1. Listar el contenido de la carpeta destino para confirmar que existe y ver qué hay alrededor.
2. Si el tema podría caber en varios lugares (ej. "logging" → ¿concepto agnóstico o tooling?), **preguntar al usuario** antes de decidir.
3. Si la solicitud es vaga ("apunte sobre listas"), pedir contexto: ¿de qué lenguaje? ¿concepto general?

## Paso 2 — Elegir formato base

1. Revisar `06-resources/templates/` y usar el template que aplique:
   - `topic-template.md` → apunte temático/conceptual (caso más común).
   - `language-readme.md` → al iniciar un lenguaje nuevo.
   - `core-readme.md` → al inicializar la carpeta `core/` de un lenguaje.
   - `ecosystem-readme.md` → al inicializar la carpeta `ecosystem/` de un lenguaje.

2. Si ningún template encaja con la solicitud, leer **1 o 2 archivos hermanos** del directorio destino e imitar su estilo: encabezados, tono, formato de bloques de código, uso de tablas, callouts (⚠️ ✅ ❌), etc.

3. No copiar el template literal: adaptarlo al tema y eliminar secciones que no apliquen.

## Paso 3 — Redactar el apunte

Generar un esqueleto mínimo coherente con el formato elegido. Como guía general:

- `# H1` con el título del tema.
- Introducción breve: qué es, para qué sirve, equivalencias con otros lenguajes si ayuda al usuario.
- Conceptos clave / contenido principal en secciones `## H2`.
- Ejemplos de código solo si aplican al tema (con el lenguaje correcto en el fence).
- Buenas prácticas, gotchas o anti-patrones si son relevantes.
- Sección "Relacionado" con enlaces a otros apuntes del jardín cuando exista relación clara.
- Referencias externas (documentación oficial, artículos) si se conocen.

Nivel de detalle: dejar el esqueleto utilizable, con los puntos clave esbozados, pero sin inventar contenido detallado. El usuario completará/ajustará.

## Paso 4 — Cierre

1. Confirmar al usuario la ruta donde se creó el archivo.
2. Resumir en 1-2 líneas qué incluye el esqueleto.
3. Preguntar si quiere ajustar algo antes de proponer el commit.
4. Al confirmar commit, sugerir mensaje en formato `docs: <descripción en español>` (ver convenciones en `CLAUDE.md`).

## Notas

- Para lenguajes ya existentes, **no inventar carpetas** — usar la estructura que ya hay.
- Si el apunte forma parte de la ruta de aprendizaje de un lenguaje y existe un `progress.md`, mencionar al usuario que quizá quiera actualizarlo, pero **no editarlo automáticamente**.
- Si después de explorar la carpeta destino se ve que el apunte encaja mejor como sección dentro de un archivo existente que como archivo nuevo, proponerlo al usuario antes de crear un archivo duplicado.
