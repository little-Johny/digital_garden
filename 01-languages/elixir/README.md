# Elixir
![Elixir Logo](https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fu2bioxgjb4ye4mnncdan.png)

## Introducción
Es un lenguaje de propósito general que se utiliza con éxito en el desarrollo web, software embebido, ingestión de datos y procesamiento multimedia.

Funciona sobre la **Virtual Machine de Erlang (BEAM)**, lo que significa que no corre como un proceso aislado, sino que hereda nativamente toda la infraestructura de Erlang. Gracias a esto, Elixir obtiene *gratis* más de 30 años de optimización en sistemas distribuidos, aprovechando el famoso planificador de procesos ligeros y la tolerancia a fallos de las telecomunicaciones, pero con una sintaxis moderna y herramientas productivas para el desarrollador.

## Características Clave

### Lenguaje Dinámico y Funcional
Diseñado para crear aplicaciones escalables y mantenibles.
- **Inmutabilidad:** Elixir tiene una colección de tipos de datos que son inmutables. Una vez que se crea un valor, no se puede modificar; en su lugar, se crea uno nuevo. Esto hace que el código sea más seguro y menos propenso a errores.
- **Macros:** Permiten generar código en tiempo de compilación (metaprogramación).

### Ecosistema Erlang (La Magia de la BEAM)
- Todo el código se ejecuta en pequeños procesos concurrentes.
- Cada proceso tiene su propio estado (aislamiento).
- Los procesos se comunican entre sí únicamente por **paso de mensajes**.

### IEx (Interactive Elixir)
Es el entorno de ejecución interactivo o **REPL** (Read-Eval-Print Loop).
> Es equivalente `php artisan tinker` para `php` y la consola del navegador para `javascript`.

Permite evaluar código en tiempo real, depurar, introspeccionar módulos y recargar código en caliente.

```elixir
"Elixir" |> String.graphemes() |> Enum.frequencies()
```

**Análisis del código:**
- **Entrada:** `"Elixir"`
- **Salida:** `%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}`
    - El resultado es un **Mapa** (Map).
    - Nota que la "i" tiene el valor `2` porque aparece dos veces.

> **Para tu mente de desarrollador:** Esto es el equivalente a un Associative Array en PHP o un Object en JavaScript (Diccionario en Python).
>
> **Nota:** La sintaxis `|>` se llama **pipe** y pasa el resultado de una función como primer argumento de la siguiente.

### Pattern Matching y Módulos (Adiós al `if/else`)
En Elixir no escribimos lógica defensiva dentro de la función. Definimos **múltiples cláusulas** de la misma función y dejamos que el lenguaje decida cuál usar según los datos.

**Código Elixir (Declarativo)**
Definimos QUÉ hacer en cada caso. El orden importa.

```elixir
defmodule Saludo do
  # 1. Caso específico
  def hola("Jefe"), do: "¡Buenos días, Señor! Todo está listo."

  # 2. Caso general
  def hola(nombre), do: "Hola, #{nombre}. ¿Qué tal tu día?"
end
```

**Diferencias clave con PHP/JS:**
- **Adiós al `return`:** Elixir retorna automáticamente el resultado de la última línea.
- **No hay Clases:** `defmodule` agrupa funciones, pero no se instancia.
- **Sobrecarga real y Aridad:** Puedes tener la misma función definida N veces. Se identifican por nombre y argumentos (ej. `hola/1` vs `hola/0`).

---

**Comparación con JavaScript (Imperativo)**
Aquí estás obligado a mezclar la lógica de control (`if`) con la lógica de negocio.

```javascript
function hola(nombre) {
  // Tienes que abrir la caja y preguntar manualmente
  if (nombre === "Jefe") {
     return "¡Buenos días, Señor! Todo está listo.";
  }
  return `Hola, ${nombre}. ¿Qué tal tu día?`;
}
```

## Ruta de Aprendizaje
Esta carpeta está organizada para guiarte desde los fundamentos hasta el dominio del ecosistema.

- **[Core](./core/README.md)**: Sintaxis, estructuras de datos y conceptos fundamentales. 
- **[Ecosystem](./ecosystem/README.md)**: Herramientas, librerías y frameworks.
- **[Projects](./projects/README.md)**: Proyectos prácticos para aplicar lo aprendido.

## Recursos
- **Documentación Oficial**: [https://elixir-lang.org/docs.html](https://elixir-lang.org/docs.html)
- **Comunidad / Foro**: [https://elixirforum.com](https://elixirforum.com)