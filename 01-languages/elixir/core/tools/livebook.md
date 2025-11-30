# Livebook

Es una aplicación web interactiva para escribir y ejecutar código Elixir.

> **Resumen:** Es el equivalente a "Jupyter Notebooks" o "Google Colab" para Elixir.

## ¿Para qué sirve?

Te permite crear "cuadernos" donde mezclas **Texto Enriquecido (Markdown)** con **Bloques de Código Ejecutable** en tiempo real. Todo se guarda en archivos con extensión `.livemd`.

### ¿Dónde encaja en tu flujo?

- **`iex` (Terminal):** Para pruebas rápidas y efímeras (se borra al cerrar).
- **VS Code (Editor):** Para construir la aplicación final y estructurada.
- **Livebook (Cuaderno):** Para **aprender, documentar y explorar**.
    - *Ideal para estudiantes:* Puedes tener tus apuntes de teoría y el código que funciona en el mismo archivo.

> **Tech Fact:** Corre localmente en tu navegador (localhost) y está construido 100% con Elixir y Phoenix, demostrando el poder del lenguaje para sistemas en tiempo real.

## 🛠️ Instalación de Livebook (Desktop App)

Es la forma recomendada y más robusta para Windows, ya que funciona como una aplicación independiente.

1. **Descargar**
    Ve a [livebook.dev](https://livebook.dev/) y descarga el instalador para Windows.

2. **Instalar**
    Ejecuta el archivo `.exe` y sigue las instrucciones estándar.

3. **Ejecutar**
    Busca "Livebook" en tu menú de inicio y ábrelo. Se abrirá una ventana dedicada (no necesitas navegador ni terminal).

    > **Ventaja:** Esta versión es "Self-contained". No depende de la configuración de tu terminal, ni de que tengas Elixir instalado en el sistema, y gestiona sus propios paquetes sin conflictos.


## 🌍 Livebook: Remote & Collaborative Access

Livebook funciona con una arquitectura **Cliente-Servidor**. Esto permite que múltiples usuarios se conecten a una misma instancia para editar y ejecutar código colaborativamente (Pair Programming en tiempo real).

### 🧠 Concepto Clave: Shared Runtime
Al conectarte a una sesión remota, no estás clonando el código en tu máquina. Ambos usuarios están operando sobre **el mismo proceso de Elixir (BEAM)** en la máquina del Host.
* Comparten memoria (variables, módulos).
* Comparten el sistema de archivos del Host.

---

### 🏠 Escenario A: Red Local (LAN / Wi-Fi)

**1. Configuración del HOST (Servidor)**
Por defecto, Livebook solo escucha en `127.0.0.1`. Debes permitir conexiones externas (`0.0.0.0`) y establecer una contraseña segura.

*En PowerShell:*
```powershellw
$env:LIVEBOOK_IP = '0.0.0.0'
$env:LIVEBOOK_PASSWORD = 'tu_password_seguro'
livebook server
```

**2. Conexión del GUEST (Invitado)**

  Averigua la IP local del Host (comando `ipconfig`, ej: `192.168.1.50`).

  Desde otra PC, abre el navegador e ingresa: `http://192.168.1.50:8080`.

  Ingresa la contraseña definida.

---

### ☁️ Escenario B: Remoto (Internet)

Para colaborar desde distintas ubicaciones sin exponer puertos peligrosos a internet, el estándar es usar una VPN Mesh (como Tailscale).

**Instalación:** Ambos instalan Tailscale y se conectan a la misma red (Tailnet).

**Host:** Inicia Livebook normalmente.

**Guest:** Usa la "Tailscale IP" de la máquina del Host para conectarse: http://100.x.x.x:8080.

>⚠️ Advertencia de Seguridad: Exponer Livebook en 0.0.0.0 sin una VPN en una red pública (cafetería, aeropuerto) es peligroso. Cualquiera con acceso podría ejecutar código en tu computadora. Úsalo solo en redes de confianza.