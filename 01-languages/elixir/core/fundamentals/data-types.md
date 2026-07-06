# Tipos de Datos y Estructuras

En Elixir, entender los tipos de datos va más allá de saber qué valores existen; implica comprender cómo la **BEAM** (Erlang VM) gestiona la memoria y la inmutabilidad.

## 1. Inmutabilidad (La Base)

En Elixir, **nada se modifica**.
Cuando transformas datos, la BEAM no sobrescribe la memoria original; crea una nueva estructura.

- **Structural Sharing:** La BEAM es eficiente. Si tienes una lista de 1 millón de items y agregas uno nuevo al inicio, **no se copian** el millón de items. Se crea el nuevo item y este apunta a la lista antigua.

---

## 2. Primitivos

### Números y Matemáticas
Elixir distingue claramente entre enteros y flotantes.

- **Enteros (`Integer`):** Números sin decimales (ej. `1`). Soporta números arbitrariamente grandes.
- **Flotantes (`Float`):** Números con decimales (ej. `1.0`). Precisión de 64-bit.

**Operadores**
> ⚠️ **Ojo con la División:** El operador `/` **siempre** devuelve un flotante.

```elixir
10 / 2      # 5.0 (Float)
div(10, 2)  # 5   (Integer - División entera)
rem(10, 3)  # 1   (Integer - Resto/Módulo)
round(3.58) # 4   (Redondeo)
trunc(3.58) # 3   (Parte entera)
```

### Átomos y Booleanos
Una característica distintiva de la BEAM.

**Átomos (`:atom`)**
Son constantes cuyo valor es su propio nombre.
- **Rendimiento:** Se almacenan en una tabla global (Atom Table) con un ID único. Compararlos es **instantáneo ($O(1)$)**.
- **Uso:** Identificadores, estados (`:ok`, `:error`), claves de mapas.

**Booleanos**
No existe un tipo "Booleano" real. Son átomos con azúcar sintáctica.
```elixir
true == :true   # true
false == :false # true
```

**Nil (`nil`)**
Representa la ausencia de valor (como `null` o `None`).
- Es también un átomo: `nil == :nil`.
- Es **Falsy**: En Elixir, todo es verdadero excepto `false` y `nil`.

---

## 3. Colecciones

### Tuplas (Tuples)
Colecciones ordenadas de tamaño fijo.
- **Sintaxis:** `{:ok, "mensaje"}`
- **Memoria (Contigua):** Bloque continuo, como un Array en C.
- **Uso:** Retornar valores fijos o agrupar datos pequeños.

### Listas (Lists)
Listas Enlazadas (Linked Lists), no Arrays.
- **Sintaxis:** `[1, 2, 3]`
- **Memoria (Dispersa):** Nodos enlazados `[Head | Tail]`.
- **Uso:** Colecciones dinámicas, iteraciones, recursión.

> **Trampa común:** Si intentas imprimir una lista de números enteros que coinciden con códigos ASCII (ej. `[65, 66]`), Elixir podría mostrarla como texto (`'AB'`). Usa `IO.inspect` para ver la estructura real.

### Resumen de Rendimiento (Big O)

| Operación | Tupla `{}` | Lista `[]` | Por qué |
| :--- | :--- | :--- | :--- |
| **Acceso por índice** | ⚡️ **$O(1)$** | 🐢 **$O(n)$** | Tupla es acceso directo; Lista debe recorrerse. |
| **Obtener tamaño** | ⚡️ **$O(1)$** | 🐢 **$O(n)$** | Tupla guarda su tamaño; Lista debe contarse. |
| **Agregar al inicio** | 🐢 **Lento** | ⚡️ **$O(1)$** | Tupla debe copiarse entera; Lista solo crea un nodo. |
| **Modificar** | 🐢 **Copia todo** | 🐢 **Copia parcial** | La inmutabilidad obliga a copiar. |

---

## 4. Funciones e Identidad

### Identidad y Aridad
Una función se define por su **Nombre** + **Aridad** (número de argumentos).
> `sumar/2` y `sumar/3` son funciones **diferentes** para el compilador.

### Funciones Anónimas
Funciones sin nombre, tratadas como datos (First-class citizens). Son **Closures**: capturan el alcance léxico (variables externas) al momento de crearse.

```elixir
tasa = 5
calcular = fn precio -> precio * tasa end # Captura 'tasa'

# Invocación con punto (.)
calcular.(10) # 50
```
**Sintaxis Corta (Capture Operator):** `&(&1 * 2)`

---

## 5. Extras

### Alias
Permite renombrar módulos para escribir menos. Tiene alcance léxico (solo vive dentro del bloque donde se define).

```elixir
alias MyApp.Utils.Math.Geometry, as: Geo
Geo.calculate()
```

-----

## 🏋️ Practicado en

- [log-level (#5)](../../exercism/log-level/README.md) — átomos
- [language-list (#6)](../../exercism/language-list/README.md) — listas
- [kitchen-calculator (#9)](../../exercism/kitchen-calculator/README.md) — tuplas
