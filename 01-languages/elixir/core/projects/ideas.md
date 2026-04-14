# Ideas de proyectos en Elixir

Generado el 2026-04-12, basado en los conceptos estudiados hasta la fecha.

---

## Nivel 1 — Consolidar lo aprendido

### CLI de notas
Un gestor de notas en la terminal. El usuario puede crear, listar y eliminar notas.

**Conceptos que refuerza:** IO, maps, funciones nombradas, pattern matching.

---

### Calculadora de gastos
Registra gastos por categoría, calcula totales y promedios. Puede mostrar un resumen al final.

**Conceptos que refuerza:** Enum, maps, fechas (Date/NaiveDateTime).

---

## Nivel 2 — Estirar un poco

### Simulador de banco
Cuentas con saldo, depósitos, retiros e historial de transacciones.

**Conceptos que refuerza:** Structs (aún no vistos), pattern matching, Enum.
**Concepto nuevo natural:** Structs como representación de entidades.

---

### Chat entre procesos
Varios "usuarios" implementados como procesos BEAM que se mandan mensajes entre sí.

**Conceptos que refuerza:** spawn, send/receive, receive loops, estado via procesos.
**Extensión directa de:** Take-A-Number (Exercism).

---

### Parser de CSV
Leer un archivo CSV, transformar cada fila en un map y permitir consultas simples (filtrar, ordenar).

**Conceptos que refuerza:** IO/File, Enum, strings, pattern matching en binarios.

---

## Nivel 3 — Algo con más sustancia

### Servidor HTTP minimalista
Usar `Task` y procesos para aceptar y manejar conexiones TCP básicas.

**Conceptos nuevos:** Task, Supervisor, tolerancia a fallos.

---

### Bot de Telegram o Discord
Consumir una API externa, parsear respuestas JSON y responder a comandos.

**Conceptos que refuerza:** Procesos, pattern matching.
**Conceptos nuevos:** HTTPoison o Req, Jason (JSON), manejo de estado entre mensajes.
