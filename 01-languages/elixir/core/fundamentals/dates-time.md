# Fechas y Tiempo

Elixir ofrece 4 módulos en su librería estándar para trabajar con fechas y tiempo, cada uno con su propio struct e identidad clara.

## 1. Los 4 Módulos

| Módulo | Sigil | Descripción |
| :--- | :--- | :--- |
| `Date` | `~D` | Solo fecha (año, mes, día) |
| `Time` | `~T` | Solo hora (hora, minuto, segundo) |
| `NaiveDateTime` | `~N` | Fecha + hora, **sin** timezone |
| `DateTime` | — | Fecha + hora, **con** timezone |

```elixir
~D[2021-01-01]            # Date
~T[13:30:45]              # Time
~N[2021-01-01 13:30:45]   # NaiveDateTime
```

> El término "Naive" significa que no tiene noción de zona horaria. Es suficiente para la mayoría de los casos cuando operas en una sola zona horaria fija.

---

## 2. Parsing desde Strings (ISO8601)

Para convertir un string con formato ISO8601 a `NaiveDateTime`:

```elixir
# Devuelve {:ok, result} o {:error, reason}
NaiveDateTime.from_iso8601("2021-01-01T13:30:45Z")
# => {:ok, ~N[2021-01-01 13:30:45]}

# Versión con !, lanza excepción si falla
NaiveDateTime.from_iso8601!("2021-01-01T13:30:45Z")
# => ~N[2021-01-01 13:30:45]
```

Equivalente para `Date`:
```elixir
Date.from_iso8601!("2021-01-01")
# => ~D[2021-01-01]
```

---

## 3. Acceso a Campos

Los structs de fecha/tiempo exponen sus campos directamente. No necesitas funciones especiales:

```elixir
datetime = ~N[2021-01-15 08:30:00]

datetime.year    # => 2021
datetime.month   # => 1
datetime.day     # => 15
datetime.hour    # => 8
datetime.minute  # => 30
```

Esto es útil para comparaciones simples con operadores comunes sobre enteros:

```elixir
# Verificar si es antes del mediodía
datetime.hour < 12   # => true
```

---

## 4. Conversiones entre Tipos

```elixir
# NaiveDateTime → Date (descarta la hora)
NaiveDateTime.to_date(~N[2021-01-15 08:30:00])
# => ~D[2021-01-15]

# NaiveDateTime → Time (descarta la fecha)
NaiveDateTime.to_time(~N[2021-01-15 08:30:00])
# => ~T[08:30:00]
```

---

## 5. Operaciones con Fechas

### Sumar días

```elixir
Date.add(~D[2021-01-01], 28)
# => ~D[2021-01-29]

Date.add(~D[2021-01-01], -7)  # Restar días
# => ~D[2020-12-25]
```

### Diferencia entre fechas

`Date.diff/2` devuelve un entero (positivo si la primera fecha es posterior):

```elixir
Date.diff(~D[2021-01-10], ~D[2021-01-03])
# => 7

Date.diff(~D[2021-01-03], ~D[2021-01-10])
# => -7
```

### Día de la semana

```elixir
Date.day_of_week(~D[2021-01-04])
# => 1  (lunes)

# 1=lunes, 2=martes, ..., 7=domingo
```

---

## 6. Comparaciones

> ⚠️ **No uses `>`, `<`, `==` directamente** con structs de fecha/tiempo. Funcionan aparentemente pero hacen comparación estructural, no semántica.

Usa las funciones `compare/2` del módulo correspondiente:

```elixir
Date.compare(~D[2021-01-10], ~D[2021-01-03])
# => :gt  (greater than)

Time.compare(~T[08:00:00], ~T[12:00:00])
# => :lt  (less than)

# Posibles resultados: :lt | :eq | :gt
```

La excepción: si extraes un campo como `.hour` (un entero), puedes compararlo normalmente con `<`, `>`, `==`.

---

## 7. Ejemplo Completo (Library Fees #21)

Este ejercicio integra todos los conceptos anteriores para calcular multas por devolución tardía de libros:

```elixir
defmodule LibraryFees do
  # 1. Parsear string ISO8601 → NaiveDateTime
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  # 2. Acceso directo al campo .hour (entero), comparación normal
  def before_noon?(datetime) do
    datetime.hour < 12
  end

  # 3. Convertir a Date, sumar días según la hora de checkout
  def return_date(checkout_datetime) do
    date = NaiveDateTime.to_date(checkout_datetime)
    if before_noon?(checkout_datetime) do
      Date.add(date, 28)
    else
      Date.add(date, 29)
    end
  end

  # 4. Date.diff para días de retraso, max/2 para asegurar >= 0
  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  # 5. day_of_week devuelve entero; 1 = lunes
  def monday?(datetime) do
    datetime |> NaiveDateTime.to_date() |> Date.day_of_week() |> Kernel.==(1)
  end

  # 6. Composición de todas las funciones anteriores
  def calculate_late_fee(checkout, return, rate) do
    checkout_date = datetime_from_string(checkout)
    real_return_date = datetime_from_string(return)
    planned_return_date = return_date(checkout_date)
    real_diff = days_late(planned_return_date, real_return_date)

    if monday?(real_return_date) do
      div(real_diff * rate, 2)   # 50% off, redondeado hacia abajo
    else
      real_diff * rate
    end
  end
end
```

---

## 8. Resumen de Funciones Clave

| Función | Descripción |
| :--- | :--- |
| `NaiveDateTime.from_iso8601!/1` | String ISO8601 → NaiveDateTime |
| `NaiveDateTime.to_date/1` | NaiveDateTime → Date |
| `NaiveDateTime.to_time/1` | NaiveDateTime → Time |
| `Date.add/2` | Suma (o resta) días a una fecha |
| `Date.diff/2` | Diferencia en días entre dos fechas |
| `Date.day_of_week/1` | Día de la semana (1=lunes, 7=domingo) |
| `Date.compare/2` | Comparación semántica → `:lt`, `:eq`, `:gt` |
| `Time.compare/2` | Comparación semántica → `:lt`, `:eq`, `:gt` |
