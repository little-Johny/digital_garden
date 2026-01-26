# 🟢 Procesos en Elixir (Green Threads)

Los procesos en Elixir son la base de la concurrencia y siguen el **Modelo de Actor**. No son procesos del sistema operativo, sino "green threads" extremadamente ligeros gestionados por la BEAM (Erlang Virtual Machine).

---

## 1. Conceptos Fundamentales

| Concepto | Descripción |
|----------|-------------|
| **Aislamiento Total** | Procesos independientes. Si uno falla, no afecta a otros (salvo que estén enlazados). |
| **Ligereza** | Gestionados por la BEAM, no el SO. Puedes tener cientos de miles. |
| **Comunicación** | Paso de mensajes asíncrono (mailbox). |
| **PID** | Identificador único del proceso. |

> **Nota Mental:** Streams = Datos perezosos. Procesos = Ejecución concurrente.

---

## 2. Funciones Clave

| Función | Descripción |
|:--------|:------------|
| `spawn/1` | Crea proceso con función anónima. Retorna PID. |
| `self/0` | Retorna PID del proceso actual. |
| `Process.alive?(pid)` | Verifica si el proceso sigue vivo. |
| `send(dest, msg)` | Envía mensaje al buzón del proceso destino (no bloqueante). |
| `receive` | Bloquea hasta recibir mensaje que haga _match_. |
| `flush/0` | (IEx) Vacía el buzón actual. |

---

## 3. Creación y Comunicación de Procesos

### Ejemplo Básico: Spawn y Envío de Mensajes

```elixir
parent = self()

# Engendrar proceso hijo
spawn(fn ->
  send(parent, {:hello, "world", self()})
end)

# Recibir en el padre
receive do
  {:hello, msg, from_pid} ->
    IO.puts("Recibido: #{msg} desde #{inspect(from_pid)}")
after
  1000 -> IO.puts("Timeout")
end
```

### Anatomía del `receive`

```elixir
receive do
  pattern1 -> # acción si hace match con pattern1
  pattern2 -> # acción si hace match con pattern2
  _        -> # catch-all para cualquier otro mensaje
after
  timeout_ms -> # acción si no llega mensaje en el tiempo especificado
end
```

---

## 4. Tolerancia a Fallos

### spawn vs spawn_link

| Función | Comportamiento ante fallo del hijo |
|---------|-----------------------------------|
| `spawn/1` | El padre **NO** se ve afectado. |
| `spawn_link/1` | El padre **MUERE** junto con el hijo (propagación de error). |

### Ejemplos

```elixir
# Shell sobrevive - el proceso hijo muere solo
spawn(fn -> raise "Oops" end)

# Shell muere y reinicia (IEx está linkeado al proceso)
spawn_link(fn -> raise "Error fatal" end)
```

### Supervisores

Los **Supervisores** son procesos especiales que monitorean otros procesos y los reinician automáticamente cuando fallan. Es la base de la filosofía "Let it crash" de Erlang/Elixir.

```
Supervisor
    |
    +-- Worker 1 (si falla, se reinicia)
    +-- Worker 2 (si falla, se reinicia)
    +-- Worker 3 (si falla, se reinicia)
```

---

## 5. Resumen Visual

```
┌─────────────────────────────────────────────────────────┐
│                      BEAM VM                            │
│  ┌─────────┐    ┌─────────┐    ┌─────────┐             │
│  │ Process │    │ Process │    │ Process │    ...      │
│  │  PID 1  │    │  PID 2  │    │  PID 3  │             │
│  │ [inbox] │◄───│ [inbox] │◄───│ [inbox] │             │
│  └─────────┘    └─────────┘    └─────────┘             │
│       │              │              │                   │
│       └──────────────┴──────────────┘                   │
│              Comunicación por mensajes                  │
└─────────────────────────────────────────────────────────┘
```

---

## 6. Cuándo Usar Procesos

- **Tareas concurrentes independientes** (ej. procesar múltiples requests)
- **Operaciones I/O bloqueantes** (ej. llamadas a APIs externas)
- **Estado aislado** (cada proceso puede mantener su propio estado)
- **Tolerancia a fallos** (aislar componentes que pueden fallar)
