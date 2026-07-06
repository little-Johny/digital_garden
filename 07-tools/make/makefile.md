# ⚙️ Make y Makefiles

Herramienta de automatización de tareas que usa un archivo `Makefile` para definir comandos (`make build`, `make test`, etc.). Muy común en proyectos C/C++, pero también usada en proyectos modernos como atajo para scripts repetitivos.

## Concepto básico

Usa reglas con formato `objetivo: dependencias` y un bloque de comandos indentado con **tabulación** (no espacios):

```makefile
# objetivo: dependencias
# <TAB>comando

test:
	mix test

build: deps
	mix compile

deps:
	mix deps.get
```

```bash
# Uso:
make test
make build
```

## Por documentar

- [ ] Variables y `.PHONY`
- [ ] Dependencias entre objetivos
- [ ] Ejemplo real en un proyecto propio
