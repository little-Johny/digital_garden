# 🚀 Roadmap de Construcción: Hangman Game (El Ahorcado)

Este documento sirve como guía de navegación para el desarrollo progresivo del juego Hangman en Elixir. Cada hito integra conceptos técnicos específicos extraídos de las lecciones de Livebook.

---

## 🏗️ Hito 1: Motor Funcional y Lógica Pura

**Referencia:** `02-getting_started.livemd`, `03-single_responsability.livemd`, `04-map_set.livemd`

### 📋 Reglas del Negocio

- **Estado inicial:** El juego comienza con una palabra, límite de vidas (5), letras acertadas y letras fallidas.
- **Procesamiento:** - Ignorar letras repetidas.
  - Si la letra existe en la palabra: agregar a aciertos (`matches`).
  - Si no existe: agregar a fallos (`misses`) y restar vida.
- **Fin del juego:** Victoria si todos los caracteres de la palabra están en `matches`. Derrota si las vidas llegan a 0.

### 🚫 Restricciones y Memos

- **Inmutabilidad:** No usar variables mutables; transformar el mapa de estado en cada función.
- **Single Responsibility:** Separar la lógica pura (`GameLogic`) de la presentación (`View`).
- **Conceptos Clave:** Pattern Matching, `Enum.all?`, e introducción a `MapSet` para unicidad de letras.

---

## 🛡️ Hito 2: Estructura y Contratos (Robustez)

**Referencia:** `05-structs.livemd`, `07-doctests.livemd`, `08-behaviour.livemd`

### 📋 Reglas del Negocio

- **Modelado:** Migrar de mapas genéricos a una `Struct` (`Hangman.State`).
- **Abstracción:** Implementar un **Behaviour** para el "Generador de Palabras". El juego no debe saber cómo se elige la palabra (Dummy, File, o API).
- **Documentación:** Cada función debe incluir `@spec` y ejemplos de uso en `@doc`.

### 🚫 Restricciones y Memos

- **Seguridad:** Usar `@enforce_keys` para garantizar la integridad del estado inicial.
- **Conceptos Clave:** `defstruct`, `@type`, `@callback` (Behaviours), y Doctests.

---

## 🧪 Hito 3: Calidad y Pruebas Automáticas

**Referencia:** `06-unit_tests.livemd`

### 📋 Reglas del Negocio

- **ExUnit:** Crear una suite de pruebas que valide flujos completos de victoria y derrota.
- **Aislamiento:** Asegurar que las pruebas de lógica no dependan de la interfaz de usuario.

---

## ⚙️ Hito 4: Concurrencia y Persistencia (OTP)

**Referencia:** `09-agent.livemd`, `10-gen_server.livemd`

### 📋 Reglas del Negocio

- **Estado en Proceso:** El estado del juego debe vivir dentro de un proceso `GenServer`.
- **Gestión de Sesiones:** Cada jugador se identifica por un nombre (proceso registrado).
- **Auto-limpieza:** Implementar un **Timeout**. Si el jugador no interactúa en X minutos, el proceso debe cerrarse para liberar memoria.

### 🚫 Restricciones y Memos

- **Modelo de Actores:** El usuario envía mensajes (`call`/`cast`) y el servidor responde.
- **Conceptos Clave:** `GenServer`, `handle_call`, `handle_cast`, `handle_info` (para el timeout).

---

## 🎨 Hito 5: Extensibilidad y Protocolos

**Referencia:** `11-protocols.livemd`

### 📋 Reglas del Negocio

- **Polimorfismo:** Implementar el protocolo `String.Chars` para que la struct `State` sepa cómo imprimirse a sí misma (`IO.puts(state)`).
- **Visualización Dinámica:** Cambiar el formato de salida dependiendo de si el juego está en curso, ganado o perdido.

---

## 📌 Guía de Correspondencia Técnica

| Hito  | Concepto Elixir                 | Archivos Livebook Relacionados |
| :---- | :------------------------------ | :----------------------------- |
| **1** | Lógica Funcional y Mapas        | 02, 03, 04                     |
| **2** | Structs, Typespecs y Behaviours | 05, 08                         |
| **3** | Testing (ExUnit y Doctest)      | 06, 07                         |
| **4** | OTP (Agents y GenServers)       | 09, 10                         |
| **5** | Protocolos y Polimorfismo       | 11                             |
