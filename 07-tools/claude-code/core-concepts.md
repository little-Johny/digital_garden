# Fundamentos de Claude Code: Context, Subagents & Tools

## 1. Introducción

**¿Qué es?**
Para aprovechar Claude Code con intención y precisión, hay cinco pilares que definen cómo piensa, recuerda y colabora: ventana de contexto, subagentes, Model Context Protocol (MCP), CLI y context engineering.

**¿Para qué sirve?**
Entender estos pilares permite estructurar sesiones más eficientes, delegar tareas complejas de forma modular y conectar Claude con el entorno de trabajo real. La clave no es escribir el prompt perfecto, sino diseñar un contexto útil.

---

## 2. Conceptos Clave

### 2.1 Ventana de Contexto (Context Window)

La **memoria de trabajo** de Claude Code: todo lo que puede procesar y recordar al mismo tiempo —código, conversación, resultados de comandos y archivos referenciados.

| Capacidad | Tokens |
|-----------|--------|
| Por defecto | 200,000 |
| Versión extendida | 1,000,000 |

**Composición del contexto:**

```
┌─────────────────────────────────────────────────┐
│               VENTANA DE CONTEXTO                │
│                                                  │
│  ┌───────────────┐   ┌─────────────────────────┐ │
│  │  Conversación │   │   Archivos / Código      │ │
│  │  (mensajes)   │   │   (referenciados con @)  │ │
│  └───────────────┘   └─────────────────────────┘ │
│                                                  │
│  ┌───────────────┐   ┌─────────────────────────┐ │
│  │  Resultados   │   │   CLAUDE.md / memoria    │ │
│  │  de comandos  │   │   persistente            │ │
│  └───────────────┘   └─────────────────────────┘ │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Gestión automática:** cuando el contexto se llena, Claude descarta lo irrelevante y conserva lo útil. Sin embargo, es mejor no depender solo de eso y mantener el contexto limpio de forma activa.

---

### 2.2 Subagentes

Instancias independientes de Claude que el agente principal puede invocar para tareas especializadas. Cada subagente tiene su propio **contexto, herramientas y foco**, lo que permite trabajar de forma modular sin saturar la sesión principal.

**Flujo de trabajo:**

```
                      ┌──────────────────────┐
                      │    Agente Principal   │
                      │    (conversación)     │
                      └──────────┬───────────┘
                                 │ delega
           ┌─────────────────────┼─────────────────────┐
           ▼                     ▼                     ▼
  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
  │  Arquitectura   │  │    Backend      │  │    Frontend     │
  │  (estructura    │  │  (APIs, lógica) │  │  (UI, estilos)  │
  │   del sistema)  │  │                 │  │                 │
  └─────────────────┘  └─────────────────┘  └─────────────────┘
                                 │
                      ┌──────────▼──────────┐
                      │         QA          │
                      │  (pruebas y         │
                      │   validación)       │
                      └─────────────────────┘
```

**Cuándo invocar cada subagente:**

| Subagente | Cuándo usarlo |
|-----------|---------------|
| Arquitectura | Diseño de sistema, estructura de módulos, decisiones de alto nivel |
| Backend | Endpoints, lógica de negocio, APIs, base de datos |
| Frontend | Componentes de UI, estilos, experiencia de usuario |
| QA | Pruebas, validación, casos borde, regresiones |

---

### 2.3 MCP (Model Context Protocol)

Un **protocolo abierto** que conecta Claude Code con herramientas externas —bases de datos, servicios, APIs— de forma nativa. Tras una configuración única, Claude puede interactuar con esas herramientas como si fueran funciones propias.

**Arquitectura:**

```
┌──────────────────────────────────────────────────┐
│                   Claude Code                     │
│                                                   │
│            interactúa via MCP servers             │
└────────┬──────────────┬──────────────┬────────────┘
         │              │              │
         ▼              ▼              ▼
  ┌────────────┐  ┌──────────┐  ┌────────────────┐
  │   GitHub   │  │  Base de │  │   Playwright   │
  │ Issues/PRs │  │  datos   │  │   (tests E2E)  │
  └────────────┘  └──────────┘  └────────────────┘
         │              │              │
  ┌──────┴──────────────┴──────────────┴───────┐
  │           Más integraciones                 │
  │      Figma · Zapier · Slack · Linear        │
  └─────────────────────────────────────────────┘
```

**Ejemplos de lo que MCP permite:**
- **GitHub:** revisar issues y pull requests sin salir del terminal
- **Base de datos:** hacer consultas directamente desde la conversación
- **Playwright:** ejecutar pruebas E2E y recibir el resultado analizado
- **Figma / Zapier / Slack:** interactuar con servicios externos como si fueran nativos

---

### 2.4 CLI (Command Line Interface)

La interfaz donde Claude Code **vive y opera**, en el mismo espacio que Git, Docker o npm. El prefijo `!` permite ejecutar comandos reales cuyo resultado Claude puede analizar e interpretar.

**Roles claros en el flujo de trabajo:**

```
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│     Terminal      │    │      Editor      │    │    Navegador     │
│                   │    │                  │    │                  │
│  Claude Code      │    │  Tú escribes     │    │  Tú validas el   │
│  ejecuta y        │    │  código          │    │  resultado       │
│  analiza          │    │                  │    │  final           │
└──────────────────┘    └──────────────────┘    └──────────────────┘
```

---

### 2.5 Context Engineering

No se trata de escribir la instrucción perfecta, sino de **diseñar un espacio de pensamiento compartido** con los datos adecuados. El contexto es el entorno donde Claude razona; cuanto más limpio y preciso, mejor el resultado.

**Contexto pobre vs. bien diseñado:**

```
❌ Contexto pobre                   ✅ Contexto bien diseñado
──────────────────────────         ──────────────────────────────────
"arregla los bugs"                 "Revisa @lib/parser.ex.
                                    El test en línea 42 falla con
"mejora el código"                  input vacío. Sigue el patrón
                                    de manejo de errores de
"implementa el login"               @lib/validator.ex"
```

**Elementos de un buen contexto:**
- **Propósito:** qué se quiere lograr
- **Límites:** qué no debe tocarse
- **Referencias:** archivos relevantes con `@`
- **Patrones:** qué seguir o evitar
- **Criterios de calidad:** cómo saber que está listo

---

## 3. Ejemplos de Uso

### Referenciar archivos en lugar de pegar código

```bash
# ❌ Satura el contexto innecesariamente
"Aquí está mi archivo: [500 líneas pegadas]..."

# ✅ Referencia directa y limpia
"Revisa @lib/user.ex y dime si el patrón de validación es consistente"
```

### Ejecutar comandos con `!` desde la CLI

```bash
# Claude ejecuta el comando y analiza el resultado en contexto
! git status
! mix test --trace
! docker ps
```

### Reiniciar sesión cuando el contexto se ensucia

```bash
# Si Claude empieza a contradecirse o a olvidar decisiones previas:
# 1. Abre una nueva sesión
# 2. Vuelve a fijar el contexto esencial

"Continuamos con @lib/auth.ex y @lib/session.ex.
 Objetivo: implementar refresh tokens.
 La sesión anterior definió el struct en @lib/token.ex — ya está hecho."
```

### Definir propósito y límites desde el inicio

```bash
# Contexto bien estructurado al arrancar una tarea compleja
"Estoy en @lib/payments.ex.
 Propósito: agregar soporte para reembolsos parciales.
 Límites: no cambiar la interfaz pública del módulo.
 Patrón a seguir: el de @lib/charges.ex.
 Criterio de calidad: todos los doctests deben pasar."
```

### Configurar un servidor MCP (ejemplo: GitHub)

```json
// En .claude/settings.json o ~/.claude/settings.json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "<tu_token>"
      }
    }
  }
}
```

---

## 4. Buenas Prácticas

- ✅ **Referenciar con `@`** en lugar de pegar bloques de código.
- ✅ **Definir propósito, límites y criterios** al iniciar tareas complejas.
- ✅ **Abrir nueva sesión** cuando la conversación pierde coherencia.
- ✅ **Indicar patrones a seguir** para mantener consistencia con el codebase.
- ✅ **Usar `!comando`** para que Claude ejecute y analice resultados reales.
- ✅ **Limpiar el contexto activamente**: no todo necesita estar siempre visible.
- ❌ **Evitar instrucciones vagas** como "mejora el código" sin contexto específico.
- ❌ **Evitar pegar grandes bloques** de código que saturan el contexto.
- ❌ **No acumular ruido** en la conversación (resultados irrelevantes, discusiones pasadas).
- ⚠️ **Gotcha — contexto no infinito:** 200k tokens es amplio, pero una conversación larga con archivos pegados se llena más rápido de lo esperado.
- ⚠️ **Gotcha — MCP requiere configuración inicial** por herramienta, pero una vez listo funciona de forma transparente en todas las sesiones.
- ⚠️ **Gotcha — subagentes no comparten contexto** entre sí: el agente principal es el integrador, no los subagentes.

---

## 5. Relacionado

- [Workflows y comandos frecuentes](./workflows.md)
- [Subagentes: uso avanzado](./agents.md)
- [Tips y buenas prácticas](./tips.md)

---

## 6. Referencias Externas

- [Claude Code Overview](https://code.claude.com/docs/en/overview.md)
- [How Claude Code Works](https://code.claude.com/docs/en/quickstart.md)
- [MCP (Model Context Protocol)](https://code.claude.com/docs/en/mcp.md)
- [Memory y CLAUDE.md](https://code.claude.com/docs/en/memory.md)
- [Settings y configuración](https://code.claude.com/docs/en/settings.md)
- [Subagentes](https://code.claude.com/docs/en/agents.md)
