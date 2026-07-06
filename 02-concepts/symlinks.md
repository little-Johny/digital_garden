# 🔗 Symlinks (Enlaces Simbólicos)

Un symlink es un puntero a un archivo o carpeta. No es una copia, sino una redirección: cuando accedes al symlink, el sistema te lleva al archivo original.

**Analogía:** Una nota adhesiva en tu escritorio que dice "el documento está en el cajón 3". La nota no es el documento, solo te redirige.

## Comportamiento clave

- Editar a través del symlink → edita el original.
- Borrar el symlink → el original queda intacto.
- Borrar el original → el symlink queda "roto" (apunta a la nada).

## Cómo crear un symlink

```bash
# ln -s <archivo_original> <nombre_del_symlink>
ln -s /ruta/al/original.md ./acceso-directo.md

# Ejemplo real: compartir un skill entre .claude y .cursor
ln -s ~/.claude/skills/my-skill.md ~/.cursor/skills/my-skill.md
```

> **Truco:** La ruta del original puede ser absoluta o relativa al symlink.

## Casos de uso útiles

| Caso | Descripción |
| :--- | :---------- |
| Compartir skills entre `.claude` y `.cursor` | Un solo archivo fuente, dos herramientas lo leen sin duplicar contenido. |
| Config files compartidos | Tener un `.zshrc` o `.gitconfig` en un repo de dotfiles y linkearlo al `$HOME`. |
| Acceso a directorios frecuentes | Crear un symlink en el escritorio que apunte a una carpeta profunda del sistema. |

## Comandos útiles

```bash
ls -la          # Muestra los symlinks con su destino (flecha ->)
readlink archivo  # Muestra a dónde apunta un symlink
unlink archivo    # Elimina el symlink sin borrar el original
```
