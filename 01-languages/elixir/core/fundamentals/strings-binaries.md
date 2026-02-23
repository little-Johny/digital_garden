# Strings, Binarios y Grafemas

En Elixir, entender el texto requiere entender cómo se almacena en memoria. Lo que llamamos "String" es, bajo el capó, un **binario** codificado en **UTF-8**.

## 1. La Jerarquía del Texto

Para manejar texto correctamente, debemos distinguir tres niveles:

| Nivel               | Descripción                               | Ejemplo (`"café"`)                    |
| :------------------ | :---------------------------------------- | :------------------------------------ |
| **Binario (Bytes)** | La representación cruda en memoria.       | `<<99, 97, 102, 195, 169>>` (5 bytes) |
| **Codepoints**      | El código único Unicode de cada caracter. | `[99, 97, 102, 233]` (4 códigos)      |
| **Grafemas**        | Lo que el ojo humano ve como una "letra". | `["c", "a", "f", "é"]` (4 grafemas)   |

### ¿Por qué importa?

En UTF-8, caracteres como la `é` o los emojis ocupan **más de 1 byte**.

- `byte_size("é")` devuelve `2`.
- `String.length("é")` devuelve `1`.

> ⚠️ **Regla de oro:** Usa siempre el módulo `String` para manipular texto, ya que entiende grafemas. Evita funciones que trabajen con bytes a menos que estés haciendo protocolos de red o archivos binarios.

---

## 2. Binarios y Bitstrings (`<< >>`)

La sintaxis `<< >>` define un binario. Un String es solo un binario donde cada caracter sigue la codificación UTF-8.

```elixir
# Esto es equivalente
"hola" == <<104, 111, 108, 97>>
```

### Pattern Matching con Binarios

Es muy potente para procesar archivos o protocolos:

```elixir
<<primero, resto::binary>> = "Elixir"
# primero -> 69 (Código ASCII de 'E')
# resto   -> "lixir"
```

---

## 3. Grafemas y Modificadores

Existen casos donde un grafema se compone de varios codepoints (ej. una letra y un acento por separado).

```elixir
# Un "manojo" de grafemas
String.graphemes("noe\u0301l")
# => ["n", "o", "e\u0301", "l"] (La 'e' con acento es un solo grafema)
```

---

## 4. El Pipe Operator (`|>`) con Strings

El operador Pipe es esencial para limpiar y transformar texto de forma legible.

```elixir
"  antigravity_ai  "
|> String.trim()
|> String.replace("_", " ")
|> String.upcase()
# => "ANTIGRAVITY AI"
```

### El Operador de Concatenación (`<>`)

A diferencia de otros lenguajes que usan `+`, Elixir usa `<>` para concatenar binarios/strings.

```elixir
"Hola" <> " " <> "Mundo" # "Hola Mundo"
```

---

## 5. Resumen de Herramientas

- `String.length/1`: Cuenta grafemas (lo que ves).
- `byte_size/1`: Cuenta bytes (memoria).
- `String.at/2`: Obtiene el grafema en una posición.
- `String.capitalize/1`, `String.upcase/1`, `String.downcase/1`.
- `is_binary/1`: Verifica si algo es un String/Binario.
