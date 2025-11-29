# Guía de Referencia Markdown

Markdown es un lenguaje de marcado ligero que puedes usar para añadir formato a elementos de texto simple. Creado por John Gruber en 2004, es ahora uno de los formatos de marcado más populares del mundo.

## 1. Sintaxis Básica

### Encabezados
Usa `#` para los encabezados. El número de `#` indica el nivel del encabezado (1-6).

```markdown
# H1 - Título Principal
## H2 - Subtítulo
### H3 - Sección
#### H4
##### H5
###### H6
```

### Énfasis

| Estilo | Sintaxis | Ejemplo | Salida |
| :--- | :--- | :--- | :--- |
| **Negrita** | `**texto**` o `__texto__` | `**Hola**` | **Hola** |
| *Cursiva* | `*texto*` o `_texto_` | `*Mundo*` | *Mundo* |
| ***Negrita y Cursiva*** | `***texto***` | `***Todo***` | ***Todo*** |
| ~~Tachado~~ | `~~texto~~` | `~~Error~~` | ~~Error~~ |

### Citas (Blockquotes)
Usa `>` para citar texto.

```markdown
> El éxito es la suma de pequeños esfuerzos repetidos día tras día.
>
> — Robert Collier
```

> El éxito es la suma de pequeños esfuerzos repetidos día tras día.
>
> — Robert Collier

## 2. Listas

### Listas Desordenadas
Puedes usar `-`, `*`, o `+`.

```markdown
- Elemento 1
- Elemento 2
  - Sub-elemento A
  - Sub-elemento B
```

### Listas Ordenadas
Usa números seguidos de un punto.

```markdown
1. Primer paso
2. Segundo paso
3. Tercer paso
```

### Listas de Tareas (Task Lists)
Útiles para seguimiento de progreso.

```markdown
- [x] Tarea completada
- [ ] Tarea pendiente
- [ ] Otra tarea pendiente
```

## 3. Enlaces e Imágenes

### Enlaces
```markdown
[Texto del enlace](URL "Título opcional")
[Google](https://google.com)
```

### Imágenes
Similar a los enlaces, pero con un `!` al principio.
```markdown
![Texto alternativo](URL_de_la_imagen "Título opcional")
![Logo](https://markdown-here.com/img/icon256.png)
```

## 4. Código

### Código en línea
Usa acentos graves (backticks) `` ` `` para resaltar código dentro de una frase.
Ejemplo: Usa la función `print()` para mostrar texto.

### Bloques de Código
Usa tres acentos graves `` ``` `` para bloques de código. Puedes especificar el lenguaje para resaltado de sintaxis.

````markdown
```python
def saludar(nombre):
    return f"Hola, {nombre}!"
```
````

## 5. Tablas

Las columnas se separan con `|` y la fila de encabezado se separa con guiones `-`. Los dos puntos `:` se usan para alinear.

```markdown
| Izquierda | Centro | Derecha |
| :--- | :---: | ---: |
| Texto | Texto | Texto |
| 100 | 200 | 300 |
```

| Izquierda | Centro | Derecha |
| :--- | :---: | ---: |
| Texto | Texto | Texto |
| 100 | 200 | 300 |

## 6. Elementos Avanzados

### Líneas Horizontales
Usa tres o más guiones, asteriscos o guiones bajos.
```markdown
---
***
___
```

### Escapar Caracteres
Si necesitas mostrar un carácter literal que Markdown usa para formato (como `*` o `#`), usa la barra invertida `\`.
`\*No es cursiva\*`

### HTML
Puedes usar etiquetas HTML puras en Markdown si es necesario.
```html
<details>
  <summary>Haz clic para expandir</summary>
  Contenido oculto aquí.
</details>
```

### Mermaid (Diagramas)
Muchos editores modernos (como GitHub, Obsidian, VS Code) soportan diagramas Mermaid.

````markdown
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
````
