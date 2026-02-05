# 🛠️ Mix: La Herramienta de Construcción de Elixir

**Mix** es una herramienta de línea de comandos (CLI) que viene integrada con Elixir. Es el centro de control para crear, compilar, probar y gestionar las dependencias de cualquier proyecto profesional en Elixir.

---

## 1. Comandos Principales de la Herramienta

| Acción                   | Comando            | Nota Técnica                                                       |
| :----------------------- | :----------------- | :----------------------------------------------------------------- |
| **Crear Proyecto**       | `mix new <nombre>` | Genera la estructura de carpetas estándar.                         |
| **Compilar**             | `mix compile`      | Transforma archivos `.ex` en archivos `.beam` (bytecode).          |
| **Ejecutar Pruebas**     | `mix test`         | Corre los scripts de prueba en la carpeta `test/`.                 |
| **Formatear Código**     | `mix format`       | Aplica las reglas de estilo oficiales de Elixir.                   |
| **Obtener Dependencias** | `mix deps.get`     | Descarga las librerías externas definidas en el archivo `mix.exs`. |
| **Consola del Proyecto** | `iex -S mix`       | Inicia IEx cargando todo el código y dependencias del proyecto.    |

---

## 2. El Archivo de Configuración: `mix.exs`

Este archivo es el cerebro del proyecto. Se escribe en Elixir (formato `.exs`) y contiene la definición y los metadatos de la aplicación.

- **Configuración del Proyecto:** Define el nombre, la versión de la aplicación y la versión de Elixir requerida.
- **Configuración de Aplicación:** Genera un archivo `.app` (manifiesto) que la máquina virtual de Erlang (BEAM) utiliza para saber cómo iniciar la aplicación y sus servicios (como el Logger).
- **Gestión de Dependencias:** A través de la función `deps/0`, se listan las librerías externas que se obtendrán desde **Hex.pm** (el gestor de paquetes de la comunidad).

---

## 3. Convenciones de Archivos: `.ex` vs `.exs`

Es fundamental entender el uso de las extensiones para organizar correctamente el código:

- **`.ex` (Archivos Compilados):**
  - Destinados a la lógica principal de la aplicación.
  - Se ubican en la carpeta `lib/`.
  - Mix los compila a bytecode binario para máxima eficiencia en ejecución.
- **`.exs` (Archivos de Script):**
  - No se compilan a disco; se interpretan "al vuelo" cada vez que se ejecutan.
  - **Uso:** Configuración (`mix.exs`), scripts de automatización y archivos de prueba (`*_test.exs`).

---

## 4. Documentación y Ecosistema Hex

Mix se integra con el repositorio de paquetes **Hex** para extender las capacidades del lenguaje.

- **Información de paquetes:** Con `mix hex.info <package_name>` puedes consultar versiones y metadatos de cualquier librería.
- **Generación de Documentación:** Mediante la librería `ex_doc`, Mix puede ejecutar la tarea `mix docs` para generar un sitio web (HTML) estático basado en los atributos `@moduledoc` y `@doc` de tus archivos.

---

## 💡 Tip: Desarrollo Interactivo

Cuando trabajas con Mix, el comando `iex -S mix` es tu mejor aliado. Te permite interactuar con tus módulos sin necesidad de compilarlos manualmente. Si realizas cambios en el código mientras la consola está abierta, puedes usar el comando:
`recompile()`
Esto actualizará los módulos modificados sin cerrar la sesión de IEx.
