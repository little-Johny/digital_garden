# Modos de Ejecución en Elixir

Elixir es un lenguaje compilado que corre sobre la BEAM (Erlang Virtual Machine), pero ofrece una experiencia de desarrollo muy flexible que a veces se siente como un lenguaje interpretado.

Existen varias formas de ejecutar código Elixir, cada una con un propósito específico.

## Concepto Clave: Tiempo de Compilación vs. Ejecución

Este es un concepto fundamental en Elixir y la BEAM.

| Concepto         | Tiempo de Compilación (Compile Time)                                            | Tiempo de Ejecución (Runtime)                                |
| :--------------- | :------------------------------------------------------------------------------ | :----------------------------------------------------------- |
| **¿Qué ocurre?** | El código se lee, se expanden los macros y se transforma en un archivo `.beam`. | El programa ya está corriendo, el usuario interactúa con él. |
| **Directivas**   | Aquí actúan `alias`, `import` y `require`.                                      | Aquí se ejecutan las funciones y el paso de mensajes.        |
| **Analogía**     | Escribir la receta de cocina.                                                   | Cocinar (el fuego está encendido).                           |

## Modos de Ejecución

## 1. IEx (Interactive Elixir)

Es el REPL (Read-Eval-Print Loop) de Elixir.

- **Uso:** Experimentación, pruebas rápidas, depuración y acceso a documentación en terminarl.
- **Comando:** `iex`
- **Ejemplo:**
  ```elixir
  iex> 1 + 1
  2
  iex> h Enum.map # Ver ayuda
  ```

## 2. Scripts (`.exs`)

Archivos con extensión `.exs` (Elixir Script).

- **Uso:** Tareas de scripting, configuración, tests.
- **Características:** Se interpretan en memoria (no generan archivos `.beam` en disco). Son más lentos de iniciar que los `.ex` compilados pero no requieren paso de compilación previo.
- **Comando:** `elixir script.exs`
- **Ejemplo:**
  ```elixir
  # hola.exs
  IO.puts "Hola desde un script"
  ```

## 3. Archivos Compilados (`.ex`)

Archivos con extensión `.ex`.

- **Uso:** Código fuente de aplicaciones y librerías.
- **Características:** Están destinados a ser compilados a _bytecode_ (`.beam`) para obtener el máximo rendimiento.
- **Nota:** Normalmente no los "ejecutas" directamente uno por uno; son parte de un proyecto Mix.

## 4. Expresiones de una línea (`-e`)

Ejecuta código directamente desde la terminal sin guardar un archivo.

- **Uso:** Pruebas ultra rápidas o integración en scripts de shell.
- **Comando:** `elixir -e "<code>"`
- **Ejemplo:**
  ```bash
  elixir -e "IO.puts 10 * 10"
  ```

## 5. Mix Projects

La forma estándar de crear aplicaciones en Elixir.

- **Uso:** Proyectos reales, dependencias, compilación, tests.
- **Comando:** `mix run` (para ejecutar la aplicación) o `iex -S mix` (para cargar la app en una consola interactiva).

## 6. Compilador (`elixirc`)

Es el compilador de Elixir.

- **Uso:** Convierte archivos `.ex` a archivos `.beam` (bytecode de la BEAM).
- **Comando:** `elixirc archivo.ex`
- **Nota:** Rara vez usarás esto manualmente. **Mix** invoca a `elixirc` por ti automáticamente y gestiona los caminos de compilación. Usarlo directamente es útil para entender que Elixir _siempre_ se compila, incluso si herramientas como `elixir` o `iex` lo ocultan compilando en memoria.
