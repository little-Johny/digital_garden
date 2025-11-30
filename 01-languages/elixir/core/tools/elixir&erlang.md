# Elixir & Erlang

### 🛠️ Instalación

---

Existen dos formas principales de instalar el entorno: la **Convencional** (Instalador gráfico) y vía **Línea de Comandos** (Scoop).

### 📦 Opción 1: Instalador Convencional (.exe)

1. **Descargar:** Ve a [elixir-lang.org/install.html](https://elixir-lang.org/install.html) y descarga el **Elixir Web Installer** (`elixir-websetup.exe`).
2. **Ejecutar:**
    - Si Windows Defender lanza una advertencia ("Protegió su PC"), haz clic en *Más información* -> *Ejecutar de todas formas*.
3. **Configurar:**
    - El instalador detectará si falta **Erlang** y lo seleccionará para descargar.
    - Si ya tienes Erlang instalado manualmente, selecciona la versión de Elixir compatible con tu versión de Erlang (ej. Elixir x.x on Erlang 28).
4. **Finalizar:** Dale "Next" hasta terminar.

---

### 🍦 Opción 2: Con Scoop (Gestor de Paquetes)

1.  **Habilitar scripts en PowerShell**
    
    Abre PowerShell y ejecuta este comando para permitir la instalación (solo afecta a tu usuario actual):
    
    ```powershell
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```
    
2. **Instalar Scoop**
    
    Descarga y ejecuta el instalador de Scoop en memoria:
    
    ```powershell
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    ```
    
3. **Instalar Elixir (y Erlang)**
    
    Una vez listo Scoop, ejecuta este comando único. Scoop instalará Erlang automáticamente porque Elixir lo necesita.
    
    ```powershell
    scoop install erlang
    scoop install elixir
    ```

---

### Verificación y Solución de `iex`

---

1. **Verificar instalación**
    
    ```powershell
    elixir -v
    ```
    
    *(Debe mostrar la versión de Elixir y Erlang/OTP).*
    
2. **Consola Interactiva (El Fix)**
    
    En PowerShell, el comando `iex` ya existe (es un alias de `Invoke-Expression`), por lo que escribirlo solo dará error.
    
    - ❌ **No uses:** `iex`
    - ✅ **Usa:** `iex.bat`
    
    > **¿Por qué?** Poner `.bat` obliga a Windows a ignorar su comando interno y buscar el ejecutable real de Elixir en el disco.
