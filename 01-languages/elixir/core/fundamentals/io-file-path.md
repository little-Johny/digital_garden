# Módulos: IO, File, Path

Elixir, al igual que Erlang, hereda mucho de la filosofía Unix/Linux. Estos tres módulos son fundamentales para interactuar con el sistema de archivos y la terminal.

## 1. Módulo IO y la "Salida Estándar"

Cuando hablamos de "Salida Estándar" (`stdout`), nos referimos a la terminal o consola donde corre el programa.

- **stdout (Salida estándar)**: Canal donde el programa imprime mensajes normales.
- **stderr (Error estándar)**: Canal separado reservado para mensajes de error.

Aunque ambos se visualizan en la misma terminal, el sistema operativo los trata como flujos diferentes (permitiendo, por ejemplo, redirigir errores a un log mientras se ve el output normal).

### Ejemplos Prácticos

```elixir
# Escribe en la terminal (stdout)
IO.puts("Hola Mundo")

# Lee lo que el usuario escribe (stdin)
nombre = IO.gets("¿Cómo te llamas? ")

# Escribir específicamente en el canal de errores (stderr)
IO.puts(:stderr, "Algo salió muy mal")
```

## 2. Módulo File (El "Linux" de Elixir)

Este módulo es la herramienta principal para manipulación de archivos.

### La diferencia del Bang (`!`)

Una convención crítica en Elixir es el uso del signo de exclamación (`!`) al final de las funciones:

- **Sin `!` (e.g., `File.read/1`)**: Retorna una tupla `{:ok, contenido}` o `{:error, razon}`.
  - _Uso:_ Cuando el archivo puede no existir y quieres manejar el error controladamente (Pattern Matching).
- **Con `!` (e.g., `File.read!/1`)**: Retorna solo el `contenido` o lanza una excepción (crash) si falla.
  - _Uso:_ Cuando el archivo **debe** existir para que el programa funcione (e.g., un archivo de configuración vital).

### Operaciones Comunes y sus equivalentes en Linux

| Elixir                         | Linux (Bash)        | Descripción                                 |
| :----------------------------- | :------------------ | :------------------------------------------ |
| `File.read!("archivo.txt")`    | `cat archivo.txt`   | Lee todo el contenido.                      |
| `File.cp("origen", "destino")` | `cp origen destino` | Copia archivos.                             |
| `File.rm_rf!("tmp")`           | `rm -rf tmp`        | Borra recursivamente (archivos y carpetas). |
| `File.mkdir("dir")`            | `mkdir dir`         | Crea un directorio.                         |

### Ejemplo: Escribir en un archivo

```elixir
# Abrir y escribir (modo binario por defecto)
{:ok, file} = File.open("notas.txt", [:write])
IO.binwrite(file, "Aprendiendo Elixir")
File.close(file)

# Forma corta para escribir todo de una vez
File.write("notas_rapidas.txt", "Contenido directo")
```

## 3. Módulo Path (Manipulación Inteligente)

El módulo `Path` es vital para la portabilidad. Evita errores comunes al trabajar con separadores de rutas (`/` en Unix vs `\` en Windows).

### Ejemplos Prácticos

```elixir
# Unir rutas de forma segura (usa el separador correcto según el OS)
# Resultado: "usuarios/documentos/notas.txt"
Path.join(["usuarios", "documentos", "notas.txt"])

# Expandir una ruta relativa a absoluta
# Si estás en /home/user, retorna "/home/user/proyecto/config"
Path.expand("./proyecto/config")

# Obtener solo el nombre del archivo
Path.basename("/home/user/foto.jpg") # "foto.jpg"

# Obtener la extensión
Path.extname("imagen.png") # ".png"
```

## Buenas Prácticas: Manejo de Errores

### ¿Por qué evitar Pattern Matching "optimista"?

Si haces esto con un archivo que podría no existir:

```elixir
# ¡PELIGRO! Si el archivo no existe, esto lanza un MatchError
{:ok, contenido} = File.read("archivo_que_no_existe.txt")
```

El lado derecho devuelve `{:error, :enoent}` (Error NO ENTry), lo cual no coincide con `{:ok, ...}`.

### La forma correcta (Case o `with`)

Si no estás seguro de la existencia del recurso, usa `case`:

```elixir
case File.read("config.json") do
  {:ok, body} ->
    IO.puts("Leído con éxito: #{String.slice(body, 0, 20)}...")

  {:error, :enoent} ->
    IO.puts("El archivo no existe.")

  {:error, reason} ->
    IO.puts("Hubo otro error: #{reason}")
end
```
