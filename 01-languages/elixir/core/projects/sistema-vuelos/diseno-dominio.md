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
> **Idioma:** los identificadores que migran a código (entidades, campos, átomos de estado)
> van en **inglés**; la prosa explicativa va en **español**. Así no se duplica nada y el
> código queda en un solo idioma, como en un proyecto real.
>
> **Orden:** operación (Flight, Aircraft, Seat, Airport, Fare) → personas (Passenger, User) → transacción (Booking, BoardingPass).

### 1.1. Flight — Vuelo (entidad central)

- `id`
- `flight_number` — identifica el *servicio/ruta* (ej. `"AV123"`), el mismo todos los días
- `aircraft_id` — referencia al Aircraft físico que hará el recorrido
- `origin_id` — referencia a Airport (§1.4)
- `destination_id` — referencia a Airport (§1.4)
- `departure` — fecha **y** hora de salida juntas en un solo `DateTime`
- `arrival` — fecha y hora de llegada, idem
- `status` — se modela en §2, no se detalla aquí

> La **capacidad** del vuelo NO se guarda aquí: se deriva del Aircraft asignado (contando sus Seats).
> Los **precios** tampoco viven aquí: están en la entidad Fare (§1.5).

### 1.2. Aircraft — Avión

- `id`
- `registration` — identidad natural del avión (matrícula / tail number)
- `model` — modelo del avión

> `seat_count` (cantidad de asientos) NO se guarda: se deriva contando los Seats con este `aircraft_id` (una sola fuente de verdad).

### 1.3. Seat — Asiento

Pertenece al **Aircraft** (es físico, se reúsa en cada vuelo). Su ocupación NO se guarda aquí: es *derivada* (ver §3).

- `id`
- `aircraft_id` — avión al que pertenece este asiento
- `code` — código del asiento (ej. `"14C"`)
- `class` — clase del asiento (ej. `:economy`, `:business`)

### 1.4. Airport — Aeropuerto

Sirve tanto para el `origin` como para el `destination` de un Flight.

- `id`
- `iata_code` — identidad natural, 3 letras (ej. `"BOG"`)
- `name` — ej. `"El Dorado"`
- `city` — ej. `"Bogotá"`
- `country_code` — código ISO de país (ej. `"CO"`)

### 1.5. Fare — Tarifa

El precio de una **clase en un vuelo**. El destino ya está implícito en el vuelo, así que el precio depende de **(flight, class)** — no se pone en cada asiento.

- `id`
- `flight_id` — vuelo al que aplica
- `class` — clase a la que aplica (ej. `:economy`, `:business`)
- `price` — precio base
- `discount` — descuento aplicable (last-minute para llenar el vuelo, fidelidad, etc.)

### 1.6. Passenger — Pasajero

La persona que viaja. **No** necesita ser un User (se puede comprar como invitado).

- `id`
- `first_name` — nombre
- `last_name` — apellido
- `document_number` — número de documento
- `document_type` — tipo de documento
- `birth_date` — fecha de nacimiento; la edad se *deriva* de aquí, no se guarda

### 1.7. User — Usuario

Cuenta de acceso al sistema. Comprar **no** exige tener cuenta (ver Booking).

- `id`
- `username`
- `password_hash` — nunca en texto plano
- `email`
- `phone`

### 1.8. Booking — Reserva

La **compra**: qué pasajero compró qué asiento en qué vuelo, por cuánto y en qué estado. Aquí vive la regla más importante (ver §3).

- `id`
- `flight_id`
- `seat_id`
- `passenger_id`
- `user_id` — **opcional**: quién compró (vacío si fue compra de invitado)
- `price_paid` — *foto* del precio al momento de comprar (no cambia si la Fare cambia después)
- `status` — `:confirmed` / `:cancelled` (ver §2.2)

### 1.9. BoardingPass — Boleto

La **tarjeta para abordar**, emitida a partir de una Booking confirmada (1:1).

- `id`
- `booking_id` — reserva de la que se emite
- _(datos operativos que aparecen más tarde: puerta, hora de embarque… por definir)_

---

## 2. Estados y transiciones

Cada entidad con "ciclo de vida" tiene estados (átomos) y transiciones **válidas** entre ellos.
Una transición no listada es un error que el código debe rechazar.

### 2.1. Estados del Flight

Una máquina de estados es un **grafo con bifurcaciones**, no una línea: desde un estado
pueden salir varias flechas (ramas alternativas), y cada vuelo real toma *una*. No todos
los vuelos pasan por todos los estados.

Estados:

- `:scheduled` — creado, aún no abre embarque
- `:delayed` — pospuesto (sigue sin volar)
- `:boarding` — pasajeros abordando
- `:in_flight` — en el aire
- `:landed` — **terminal**, ciclo completado con éxito
- `:cancelled` — **terminal**, el vuelo no se realizará

Transiciones válidas (ramas):

```
:scheduled  → :boarding      (a tiempo)
:scheduled  → :delayed       (se retrasa)
:scheduled  → :cancelled     (se cancela antes de abrir)

:delayed    → :boarding      (finalmente embarca)
:delayed    → :cancelled     (se cancela estando retrasado)

:boarding   → :in_flight     (despega)
:boarding   → :cancelled     (se cancela en puerta)

:in_flight  → :landed        (único camino)
```

> **Terminales:** `:landed` y `:cancelled` no tienen salida — ahí termina el ciclo.
> Desde `:in_flight` NO se puede cancelar (un avión en el aire no se "cancela": eso sería
> un desvío/emergencia, otro concepto fuera de la Fase 1).

### 2.2. Estados del Booking

- `:confirmed` — compra completada
- `:cancelled` — anulada por el pasajero o el sistema

Transición:

```
:confirmed → :cancelled
```

---

## 3. Reglas de negocio (invariantes)

Cosas que **siempre** deben cumplirse. En Elixir se vuelven funciones que devuelven
`{:ok, ...}` (se cumple) o `{:error, motivo}` (se viola). Protegen al dominio de estados imposibles.

### 3.1. Reglas de operación (sobre acciones)

**Al crear un Booking (reservar un asiento):**

- [x] **No doble reserva (ocupación derivada):** no se puede crear un Booking para un `seat_id` que ya tiene un Booking `:confirmed` en el mismo `flight_id`. La ocupación de un asiento en un vuelo *es* la existencia de ese booking.
- [x] **Consistencia seat ↔ aircraft:** el `seat_id` de un Booking debe pertenecer al Aircraft (`aircraft_id`) asignado al `flight_id`. (surge de que el Seat pertenece al Aircraft, no al Flight)
- [x] **Estado del Flight permitido:** solo se reserva si el Flight está en `:scheduled` o `:delayed`. En `:boarding` se permite **venta de último minuto** si hay cupo en el avión (⚠️ regla futura: además, que el pasajero no lleve equipaje — depende de modelar **Baggage** en Fase 2; por ahora en Fase 1 solo se valida el cupo). En `:in_flight`, `:landed` y `:cancelled` NO se puede reservar.
- [x] **Debe existir Fare para la clase:** para reservar un Seat de cierta `class`, tiene que existir una Fare `(flight_id, class)`; si no, no hay precio que cobrar.
- [x] **Varios bookings por passenger (permitido):** un mismo Passenger SÍ puede tener varios bookings en el mismo vuelo (asientos distintos: equipaje, comodidad). No hay tope por pasajero — el límite real lo pone "no doble reserva" a nivel de *seat*.

**Al cancelar un Booking:**

- [x] Un Booking solo se cancela desde `:confirmed` (ver §2.2). Al pasar a `:cancelled`, el asiento se libera automáticamente (la ocupación es derivada).

### 3.2. Invariantes de datos (formas válidas)

- [x] **`origin_id ≠ destination_id`:** un vuelo no puede salir y llegar al mismo aeropuerto.
- [x] **`departure < arrival`:** no se puede llegar antes de salir.
- [x] **`price_paid` coherente:** al reservar, `price_paid = price − discount` de la Fare vigente en ese momento (*snapshot*; no cambia si la Fare cambia después).

> Las reglas nuevas que surjan en fases siguientes se agregan aquí.

---

## 4. Decisiones abiertas

Registro de las bifurcaciones de diseño pendientes. Resolver antes de codear cada hito.

| # | Decisión | Opciones | Elegida |
|---|---|---|---|
| D1 | Modelo de Seat | (a) contador de cupos · (b) asiento concreto (14C) como entidad | **(b)** entidad Seat (del Aircraft); ocupación *derivada* del Booking |
| D2 | Aircraft físico | (a) fuera por ahora · (b) entidad Aircraft con `registration` | **(b)** entidad Aircraft |
| D3 | Origin/Destination | (a) string · (b) código IATA · (c) entidad Airport | **(c)** entidad Airport (reusada en origin y destination) |

> D1–D3 quedaron resueltas al cerrar la §1. Las decisiones nuevas se agregan aquí a medida que surjan.

---

## 5. Relacionado

- [Typespecs](../../fundamentals/typespecs.md) — para tipar las entidades y funciones del núcleo
- [Ideas de proyectos](../ideas.md)
