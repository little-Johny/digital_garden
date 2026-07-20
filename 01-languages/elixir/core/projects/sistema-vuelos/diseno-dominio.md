# Sistema de Gestión de Vuelos — Diseño de Dominio

> Documento de diseño **en papel**, antes de escribir código. Aquí modelamos entidades,
> estados y reglas. El código vendrá después y casi se escribe solo cuando esto esté claro.

## 0. Sobre este proyecto

Proyecto de aprendizaje en Elixir. Crece por **capas**, de adentro hacia afuera:

1. **Núcleo funcional puro** — `structs` + funciones sin efectos secundarios + tests. (← empezamos aquí)
2. **Estado y concurrencia (OTP)** — un `GenServer` por vuelo, supervisado.
3. **Persistencia** — Ecto + PostgreSQL.
4. **Interfaz** — API REST / LiveView / CLI.

Regla de trabajo: cada hito se resuelve vía `/practicar` — yo coacheo, el código lo escribe el autor.

---

## 1. Entidades

Para cada entidad: ¿qué datos la componen? Empezar por lo **mínimo indispensable**, no por todo lo imaginable.

> **Formato:** por ahora usamos lista simple (boceto). Cuando el modelo esté maduro,
> lo migramos a tablas (`Campo | Tipo | Nota`) para el detalle fino de tipos.
> Convención de la lista: `campo` — nota/descripción opcional.
>
> **Orden:** operación (Vuelo, Avión, Asiento, Aeropuerto, Tarifa) → personas (Pasajero, User) → transacción (Reserva, Boleto).

### 1.1. Vuelo (entidad central)

- `id`
- `numero_vuelo` — identifica el *servicio/ruta* (ej. `"AV123"`), el mismo todos los días
- `avion_id` — referencia al Avión físico que hará el recorrido
- `origen_id` — referencia a Aeropuerto (§1.4)
- `destino_id` — referencia a Aeropuerto (§1.4)
- `salida` — fecha **y** hora juntas en un solo `DateTime`
- `llegada` — idem
- `estado` — se modela en §2, no se detalla aquí

> La **capacidad** del vuelo NO se guarda aquí: se deriva del avión asignado (contando sus asientos).
> Los **precios** tampoco viven aquí: están en la entidad Tarifa (§1.5).

### 1.2. Avión

- `id`
- `matricula` — identidad natural del avión (placa / tail number)
- `modelo`

> `cantidad_asientos` NO se guarda: se deriva contando los Asientos con este `avion_id` (una sola fuente de verdad).

### 1.3. Asiento

Pertenece al **Avión** (es físico, se reúsa en cada vuelo). Su ocupación NO se guarda aquí: es *derivada* (ver §3).

- `id`
- `avion_id` — avión al que pertenece este asiento
- `codigo` — código del asiento (ej. `"14C"`)
- `clase` — clase del asiento (ej. `:economica`, `:ejecutivo`)

### 1.4. Aeropuerto

Sirve tanto para el `origen` como para el `destino` de un Vuelo.

- `id`
- `codigo_iata` — identidad natural, 3 letras (ej. `"BOG"`)
- `nombre` — ej. `"El Dorado"`
- `ciudad` — ej. `"Bogotá"`
- `pais_iso` — código ISO de país (ej. `"CO"`)

### 1.5. Tarifa

El precio de una **clase en un vuelo**. El destino ya está implícito en el vuelo, así que el precio depende de **(vuelo, clase)** — no se pone en cada asiento.

- `id`
- `vuelo_id` — vuelo al que aplica
- `clase` — clase a la que aplica (ej. `:economica`, `:ejecutivo`)
- `precio` — precio base
- `descuento` — descuento aplicable (last-minute para llenar el vuelo, fidelidad, etc.)

### 1.6. Pasajero

La persona que viaja. **No** necesita ser un User (se puede comprar como invitado).

- `id`
- `nombre`
- `apellido`
- `documento`
- `tipo_documento`
- `fecha_nacimiento` — la edad se *deriva* de aquí, no se guarda

### 1.7. User

Cuenta de acceso al sistema. Comprar **no** exige tener cuenta (ver Reserva).

- `id`
- `username`
- `password_hash` — nunca en texto plano
- `email`
- `phone`

### 1.8. Reserva

La **compra**: qué pasajero compró qué asiento en qué vuelo, por cuánto y en qué estado. Aquí vive la regla más importante (ver §3).

- `id`
- `vuelo_id`
- `asiento_id`
- `pasajero_id`
- `user_id` — **opcional**: quién compró (vacío si fue compra de invitado)
- `precio_pagado` — *foto* del precio al momento de comprar (no cambia si la Tarifa cambia después)
- `estado` — `:confirmada` / `:cancelada` (ver §2.2)

### 1.9. Boleto

La **tarjeta para abordar**, emitida a partir de una Reserva confirmada (1:1).

- `id`
- `reserva_id` — reserva de la que se emite
- _(datos operativos que aparecen más tarde: puerta, hora de embarque… por definir)_

---

## 2. Estados y transiciones

Cada entidad con "ciclo de vida" tiene estados (átomos) y transiciones **válidas** entre ellos.
Una transición no listada es un error que el código debe rechazar.

### 2.1. Estados del Vuelo

Una máquina de estados es un **grafo con bifurcaciones**, no una línea: desde un estado
pueden salir varias flechas (ramas alternativas), y cada vuelo real toma *una*. No todos
los vuelos pasan por todos los estados.

Estados:

- `:programado` — creado, aún no abre embarque
- `:retrasado` — pospuesto (sigue sin volar)
- `:embarcando` — pasajeros abordando
- `:en_vuelo` — en el aire
- `:aterrizado` — **terminal**, ciclo completado con éxito
- `:cancelado` — **terminal**, el vuelo no se realizará

Transiciones válidas (ramas):

```
:programado  → :embarcando      (a tiempo)
:programado  → :retrasado       (se retrasa)
:programado  → :cancelado       (se cancela antes de abrir)

:retrasado   → :embarcando      (finalmente embarca)
:retrasado   → :cancelado       (se cancela estando retrasado)

:embarcando  → :en_vuelo        (despega)
:embarcando  → :cancelado       (se cancela en puerta)

:en_vuelo    → :aterrizado      (único camino)
```

> **Terminales:** `:aterrizado` y `:cancelado` no tienen salida — ahí termina el ciclo.
> Desde `:en_vuelo` NO se puede cancelar (un avión en el aire no se "cancela": eso sería
> un desvío/emergencia, otro concepto fuera de la Fase 1).

### 2.2. Estados de la Reserva

- `:confirmada` — compra completada
- `:cancelada` — anulada por el pasajero o el sistema

Transición:

```
:confirmada → :cancelada
```

---

## 3. Reglas de negocio (invariantes)

Cosas que **siempre** deben cumplirse. En Elixir se vuelven funciones que devuelven
`{:ok, ...}` (se cumple) o `{:error, motivo}` (se viola). Protegen al dominio de estados imposibles.

### 3.1. Reglas de operación (sobre acciones)

**Al reservar un asiento:**

- [x] **No doble reserva (ocupación derivada):** no se puede crear una Reserva para un `asiento_id` que ya tiene una Reserva `:confirmada` en el mismo `vuelo_id`. La ocupación de un asiento en un vuelo *es* la existencia de esa reserva.
- [x] **Consistencia asiento ↔ avión:** el `asiento_id` de una Reserva debe pertenecer al avión (`avion_id`) asignado al `vuelo_id`. (surge de que el Asiento pertenece al Avión, no al Vuelo)
- [x] **Estado del vuelo permitido:** solo se reserva si el vuelo está en `:programado` o `:retrasado`. En `:embarcando` se permite **venta de último minuto** si hay cupo en el avión (⚠️ regla futura: además, que el pasajero no lleve equipaje — depende de modelar **Equipaje** en Fase 2; por ahora en Fase 1 solo se valida el cupo). En `:en_vuelo`, `:aterrizado` y `:cancelado` NO se puede reservar.
- [x] **Debe existir Tarifa para la clase:** para reservar un asiento de cierta clase, tiene que existir una Tarifa `(vuelo_id, clase)`; si no, no hay precio que cobrar.
- [x] **Varias reservas por pasajero (permitido):** un mismo pasajero SÍ puede tener varias reservas en el mismo vuelo (asientos distintos: equipaje, comodidad). No hay tope por pasajero — el límite real lo pone "no doble reserva" a nivel de *asiento*.

**Al cancelar una reserva:**

- [x] Una Reserva solo se cancela desde `:confirmada` (ver §2.2). Al pasar a `:cancelada`, el asiento se libera automáticamente (la ocupación es derivada).

### 3.2. Invariantes de datos (formas válidas)

- [x] **`origen_id ≠ destino_id`:** un vuelo no puede salir y llegar al mismo aeropuerto.
- [x] **`salida < llegada`:** no se puede llegar antes de salir.
- [x] **`precio_pagado` coherente:** al reservar, `precio_pagado = precio − descuento` de la Tarifa vigente en ese momento (*snapshot*; no cambia si la Tarifa cambia después).

> Las reglas nuevas que surjan en fases siguientes se agregan aquí.

---

## 4. Decisiones abiertas

Registro de las bifurcaciones de diseño pendientes. Resolver antes de codear cada hito.

| # | Decisión | Opciones | Elegida |
|---|---|---|---|
| D1 | Modelo de asiento | (a) contador de cupos · (b) asiento concreto (14C) como entidad | **(b)** entidad Asiento (del Avión); ocupación *derivada* de la Reserva |
| D2 | Avión físico | (a) fuera por ahora · (b) entidad Avión con matrícula | **(b)** entidad Avión |
| D3 | Origen/Destino | (a) string · (b) código IATA · (c) entidad Aeropuerto | **(c)** entidad Aeropuerto (reusada en origen y destino) |

> D1–D3 quedaron resueltas al cerrar la §1. Las decisiones nuevas se agregan aquí a medida que surjan.

---

## 5. Relacionado

- [Typespecs](../../fundamentals/typespecs.md) — para tipar las entidades y funciones del núcleo
- [Ideas de proyectos](../ideas.md)
