# 🎛️ Estructuras de Control

En Elixir, las estructuras de control funcionan diferente a otros lenguajes: **todo es una expresión**, lo que significa que siempre retornan un valor.

## 1. 🔀 If & Unless

Son macros utilizadas para evaluar **una sola condición**. A diferencia de `case` o `cond`, no están hechas para múltiples ramas, sino para lógica binaria simple.

### 🆚 Diferencias Básicas

  * **`if`:** Ejecuta el bloque si la condición es **Truthy** (cualquier cosa excepto `false` o `nil`).
  * **`unless`:** Es lo opuesto. Ejecuta el bloque si la condición es **Falsy** (`false` o `nil`).
      * *Mentalidad:* Léelo como "A menos que...".

<!-- end list -->

```elixir
if true, do: "Se ejecuta"
unless true, do: nil # No se ejecuta
unless false, do: "Se ejecuta"
```

### 🚫 La Regla de Oro del `else`

Ambos soportan la cláusula `else`, pero hay una convención de estilo muy importante en la comunidad Elixir:

> **Best Practice:** Nunca uses `else` con `unless`.

**¿Por qué?**
Genera una doble negación lógica que es difícil de leer: *"A menos que esto sea verdad, haz X, si no, haz Y"*. Es confuso.

  * ❌ **Mal:**
    ```elixir
    unless es_valido do
      "Error"
    else
      "Éxito" # Confuso: ¿Cuándo llego aquí?
    end
    ```
  * ✅ **Bien:** Si necesitas un `else`, invierte la condición y usa un `if`.
    ```elixir
    if es_valido do
      "Éxito"
    else
      "Error"
    end
    ```

### 📦 Alcance de Variables (Variable Scope)

Este es el concepto más crítico que demostró tu Livebook.

En Elixir, las estructuras de control (`if`, `case`, `cond`, etc.) **crean su propio ámbito léxico (scope)**.

**La Regla:**

> Si declaras una variable o cambias su valor dentro de un bloque `if/unless`, ese cambio **muere dentro del bloque**. No afecta a las variables de afuera.

#### El Error Común (Shadowing)

En tu ejemplo, intentaste modificar `x` dentro del `if`, pero al imprimirla afuera, seguía valiendo 1.

```elixir
x = 1

if true do
  x = x + 1 # Esta 'x' es una NUEVA variable que solo vive aquí dentro.
  # Al terminar el bloque, esta 'x' (que vale 2) desaparece.
end

IO.puts(x) 
# Output: 1 (La variable original nunca se tocó)
```

  * **El Warning:** Por eso Livebook te dio el aviso: `warning: variable "x" is unused`. Elixir detectó que creaste una `x` interna (valor 2) y nunca la usaste, mientras la `x` externa seguía intacta.

#### ✅ La Solución Correcta (Rebinding)

Como en Elixir **todo retorna un valor**, debes capturar el resultado del `if` y asignarlo a la variable.

```elixir
x = 1

# El 'if' retorna el resultado de su última línea (2)
x = if true do
  x + 1
end

IO.puts(x)
# Output: 2
```

-----

## 2. Case (Pattern Matching Switch)

Es la herramienta más potente para el control de flujo. Compara un valor contra múltiples patrones secuencialmente.

  * **Evaluación:** De arriba a abajo. Se detiene en la primera coincidencia.
  * **Variable Scope:** Las variables que asignes dentro de una cláusula del `case` mueren allí (no "fugan" hacia afuera).
  * **Strict Matching:** Si ninguna cláusula coincide, Elixir lanza un `** (CaseClauseError)`.

### Catch-all (`_`)

Es el equivalente al `default` de otros lenguajes. Es vital ponerlo al final si quieres evitar errores cuando ningún patrón anterior encaja.

```elixir
case {1, 2, 3} do
  {4, 5, 6} -> "No coincide"
  {1, x, 3} -> "Coincide y bindea x = 2"
  _ -> "Esta cláusula atrapa todo lo demás"
end
```

### 🛡️ Guard Clauses (`when`) y Supresión de Errores

Las guardias permiten agregar lógica extra al patrón (ej. `x > 0`).

**Característica Vital (Error Suppression):**
Las guardias tienen una propiedad especial: **No lanzan excepciones si fallan**. Si una función dentro de un `when` causa un error (por ejemplo, intentar sacar la longitud de un número), la guardia simplemente se evalúa como `false` y el `case` continúa probando la siguiente opción.

```elixir
case 1 do
  # hd(x) normalmente fallaría porque x es un número, no una lista.
  # Pero al estar en la guardia, el error se suprime y cuenta como "false".
  x when hd(x) -> "Nunca entrará aquí, pero no crashea"
  x -> "Entra aquí: #{x}"
end
```

-----

## 3. Cond (Condiciones Lógicas)

Se utiliza cuando necesitas verificar condiciones que **no** dependen de un único valor común (como un `if...else if...else` encadenado).

  * **Truthy Values:** En Elixir, **todo** es verdadero excepto `false` y `nil`.
      * `0` es verdadero.
      * `""` (string vacío) es verdadero.
      * `[]` (lista vacía) es verdadero.
  * **Seguridad:** Si ninguna condición se cumple, lanza `** (CondClauseError)`.

### El Patrón `true`

Para evitar el crash, siempre se agrega `true` como última opción (actúa como el `else` final).

```elixir
cond do
  2 + 2 == 5 -> "No"
  hd([1, 2]) == 10 -> "No" # hd([1,2]) es 1, así que 1 == 10 es false
  true -> "Esto se ejecuta si todo lo anterior falla"
end
```

> **Nota Técnica:** `hd([1, 2, 3])` retorna `1`. Como `1` no es ni `false` ni `nil`, Elixir lo considera **Verdadero**. Si pones esa expresión sola en una línea de `cond`, se ejecutará.

-----

## 4. With (The "Happy Path")

Esta estructura es esencial en Elixir profesional. Sirve para reemplazar los "pyramid of doom" (muchos `case` o `if` anidados). Permite definir una serie de pasos que **deben** salir bien.

  * **Funcionamiento:** Ejecuta las cláusulas en orden.
  * **Éxito:** Si el patrón de la izquierda coincide (`<-`), pasa a la siguiente línea.
  * **Fallo:** Si un patrón no coincide, la cadena se rompe inmediatamente y devuelve el valor que falló (o ejecuta el bloque `else`).

<!-- end list -->

```elixir
input = %{"login" => "alice", "email" => "alice@example.com"}

with {:ok, login} <- Map.fetch(input, "login"),
     {:ok, email} <- Map.fetch(input, "email"),
     true <- String.contains?(email, "@") do
  
  "Usuario #{login} validado con email #{email}"

else
  :error -> "Falta un campo en el mapa"
  false -> "El email no es válido"
end
```

**¿Por qué usarlo?**
Mantiene el código plano y legible. Si `Map.fetch` falla (devuelve `:error`), salta directo al `else` sin ejecutar el resto.
