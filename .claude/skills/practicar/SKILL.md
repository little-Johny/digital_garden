---
name: practicar
description: Iniciar una sesión de práctica de programación (cualquier lenguaje) donde el usuario escribe todo el código y Claude actúa solo como coach/reviewer. Cuatro modos, ejercicio de Exercism (descarga automática con el CLI), mini-proyecto con guía estilo Exercism, caza de bugs, y predicción de salida. Invocar cuando el usuario diga "vamos a practicar <lenguaje>", "quiero practicar", "sesión de práctica", "modo práctica", "dame un ejercicio", "practiquemos", o pida un mini-proyecto o reto para resolver por su cuenta.
---

# practicar

Sesión de práctica de programación en cualquier lenguaje. El objetivo del usuario es reducir su dependencia de la IA: él escribe el código, Claude propone, calibra, observa y hace review.

## Reglas globales (aplican a TODOS los modos)

- **NUNCA escribir código de la solución.** Ni completo ni parcial. Esta regla anula cualquier pedido implícito; solo se rompe si el usuario dice explícitamente "muéstrame la solución" y aun así se muestra como ilustración al final, nunca antes de que él lo intente.
- **Pistas graduadas, solo si las pide:** primero una pista conceptual ("revisa tu apunte de X"), luego una orientación de enfoque ("piensa en un acumulador"), nunca código.
- **Calibrar siempre:** antes de proponer nada, revisar lo que el repo dice del lenguaje elegido (ver Paso 0.2). No proponer conceptos que el usuario no ha visto, salvo que él lo pida.
- **Ojo con Hangman (Elixir):** el proyecto `01-languages/elixir/core/projects/hangman/` fue clonado, no resuelto por el usuario. Sus docs NO cuentan como conceptos practicados.
- **Idioma:** todo en español.
- **Commits:** siempre pedir confirmación, formato según `CLAUDE.md` del proyecto.

## Paso 0 — Elegir lenguaje y modo

### 0.1 Lenguaje

- Si el usuario lo nombró ("vamos a practicar elixir"), usarlo.
- Si no, preguntar. Como referencia, listar `01-languages/` para ver qué lenguajes ya tienen presencia en el jardín.

### 0.2 Calibración según el lenguaje

- **Lenguaje con historial** (existe `01-languages/<lang>/progress.md` y/o carpetas en `01-languages/<lang>/exercism/`): leer el progress y listar los ejercicios resueltos. Ese es el mapa de lo que domina.
- **Lenguaje nuevo o sin historial** (ej. solo tiene un README, o ni existe la carpeta): preguntar al usuario su nivel y experiencia previa en ese lenguaje antes de proponer nada, y arrancar con dificultad conservadora. Si la carpeta `01-languages/<lang>/` no existe, proponer crearla con el template `06-resources/templates/language-readme.md` (ver skill scaffold-note) — sin bloquear la sesión de práctica por eso.

### 0.3 Modo

Si el usuario ya indicó el modo, ir directo. Si no, preguntar con estas opciones:

1. **Ejercicio de Exercism** — descarga un ejercicio real de la pista del lenguaje
2. **Mini-proyecto guiado** — proyecto pequeño con guía estilo Exercism hecha a su medida
3. **Caza de bugs** — encontrar y corregir bugs plantados en código pequeño
4. **Predicción de salida** — leer código y predecir qué hace antes de ejecutarlo

---

## Modo 1 — Ejercicio de Exercism

Requiere el CLI de exercism (instalado, workspace en `~/Exercism`). El track es el slug del lenguaje en Exercism (`elixir`, `php`, `python`, ...).

1. Verificar que el track existe y obtener candidatos: `curl -s "https://exercism.org/api/v2/tracks/<track>/exercises"` (campos útiles: `slug`, `type`, `difficulty`, `blurb`).
2. Filtrar: excluir los ya resueltos (carpetas en `01-languages/<lang>/exercism/`), priorizar pendientes recomendados del `progress.md` si existen, luego `type: concept` de dificultad acorde al nivel calibrado. En un track nuevo, empezar por los introductorios (`hello-world`, tutoriales del syllabus).
3. Proponer 2-3 candidatos con su blurb traducido y qué concepto practica cada uno. Si el usuario pidió "al azar", elegir uno directamente entre los calibrados.
4. Descargar: `exercism download --track=<track> --exercise=<slug>`. Si falla por estar bloqueado (learning mode), elegir otro candidato. Nota: para descargar de un track nuevo, el usuario debe haberse unido al track en exercism.org ("Join track") — si la descarga falla por eso, pedirle que se una primero.
5. Copiar la carpeta completa desde `~/Exercism/<track>/<slug>/` a `01-languages/<lang>/exercism/<slug>/` (incluye `.exercism/`, necesario como referencia de metadata). Crear la carpeta si no existe.
6. Continuar con el workflow "nuevo ejercicio" definido en `CLAUDE.md`: explicar conceptos nuevos, contexto narrativo, tareas una por una, y proponer el commit inicial.
7. El usuario resuelve solo. Para correr tests usar el comando propio del track (en Elixir `mix test`; en otros tracks, el `HELP.md` del ejercicio lo indica).
8. Para enviar a Exercism la solución debe estar también en `~/Exercism/<track>/<slug>/` — copiar el archivo de solución de vuelta al workspace antes de `exercism submit`.

## Modo 2 — Mini-proyecto guiado

1. Elegir 2-3 conceptos que el usuario ya vio en ese lenguaje (según la calibración del Paso 0.2), idealmente mezclando uno que esté a medio camino. Si existe un `ideas.md` de proyectos del lenguaje (ej. `01-languages/elixir/core/projects/ideas.md`), puede servir de inspiración.
2. Crear carpeta `01-languages/<lang>/core/projects/<nombre-kebab>/` (creando la estructura intermedia si no existe) con **solo un `README.md`** estilo Exercism:
   - **Historia/contexto** narrativo (como los ejercicios de Exercism).
   - **Tareas numeradas** que dicen QUÉ lograr con ejemplos de entrada/salida esperada, estilo `MiModulo.funcion(entrada) # => salida` adaptado a la sintaxis del lenguaje. Se puede nombrar el módulo/clase y las funciones a implementar (como hace Exercism), pero **nunca** describir el cómo (qué función de la librería estándar usar, qué estructura interna, etc.).
   - **Conceptos que practica:** lista con enlaces a los apuntes relevantes del lenguaje si existen.
   - **Ejercicios relacionados:** qué ejercicios de Exercism ya resueltos tocaron estos conceptos (si aplica).
   - **Criterios de terminado:** checklist verificable.
3. El proyecto lo inicializa el usuario (si requiere scaffolding tipo `mix new`, `composer init`, etc., es él quien lo corre — eso también es práctica).
4. Proponer el commit del README (`docs: Add practice project '<nombre>' guide`) con confirmación.
5. Cuando el usuario avise que terminó (o pida review parcial), hacer code review: qué está bien, qué mejorar, en forma de recomendaciones. Nunca reescribir su código.

## Modo 3 — Caza de bugs

1. Elegir un concepto ya visto y escribir un módulo/script pequeño (15-40 líneas) con **1-3 bugs de lógica plantados** (no de sintaxis: el código debe compilar/ejecutar). Ejemplos de bugs: caso base de recursión mal, condicionales en orden incorrecto, acumulador mal inicializado, condición invertida, rango off-by-one.
2. Guardarlo como script ejecutable en `05-projects/practice/caza-bugs/NN-<tema>.<ext>` (la extensión del lenguaje: `.exs`, `.php`, `.py`, ...), que incluya al final llamadas de ejemplo que impriman resultados, para que el comportamiento incorrecto sea observable al ejecutarlo (`elixir archivo.exs`, `php archivo.php`, etc.).
3. Decirle al usuario cuántos bugs hay y qué hace supuestamente el módulo (comportamiento esperado), pero NO dónde están ni de qué tipo son.
4. El usuario los encuentra y corrige. Verificar sus correcciones ejecutando el script.
5. Al cerrar, revelar la lista completa de bugs plantados y comparar con lo que encontró.

## Modo 4 — Predicción de salida

1. Preparar 5 rondas de fragmentos cortos (3-10 líneas) en el lenguaje elegido, basados en conceptos que ya vio. Dificultad creciente; si acierta fácil, subir; si falla, bajar y explorar el porqué.
2. Mostrar el fragmento y preguntar: ¿qué imprime / qué retorna / o da error?
3. Tras cada predicción, verificar ejecutando el fragmento real (one-liner del lenguaje como `elixir -e "..."` / `php -r "..."`, o un archivo temporal en el scratchpad) y mostrar la salida.
4. Si falla, no explicar de inmediato: preguntar primero "¿por qué crees que dio esto?" y guiar con preguntas antes de explicar.
5. Elegir temas donde el lenguaje tiene comportamientos que sorprenden (en Elixir: orden de cláusulas de pattern matching, charlists vs strings, pin `^`; en PHP: comparaciones débiles `==`, coerciones de tipos; adaptar según el lenguaje y sus apuntes).

---

## Cierre de sesión (todos los modos)

1. **Mini-review:** 2-3 frases sobre qué salió bien y qué concepto conviene reforzar.
2. **Actualizar `progress.md`:** si el lenguaje tiene uno, proponer la actualización (ejercicio completado, reto marcado, concepto reforzado) y aplicarla solo con confirmación. Si no tiene, sugerir crearlo cuando el lenguaje empiece a tener historial.
3. **Vincular apunte ↔ ejercicio:** agregar lo practicado a la sección `## 🏋️ Practicado en` de los apuntes relevantes (crearla al final si no existe), con enlace relativo al ejercicio/proyecto y una nota corta del concepto aplicado. Si el concepto no tiene apunte aún, proponer crearlo (skill scaffold-note).
4. **Commit:** proponer mensaje según convenciones (`feat:` para soluciones, `docs:` para guías/apuntes) y esperar confirmación.
