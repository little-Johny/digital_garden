# CLAUDE.md — Platziflix

## Descripción del proyecto

Plataforma de streaming de cursos educativos. Proyecto del curso de Claude Code de Platzi (profesor: Eduardo Alvarez). Compuesto por tres sub-proyectos independientes que comparten el mismo backend.

## Arquitectura general

```
Frontend (Next.js)  ──┐
iOS (SwiftUI)       ──┼──► Backend (FastAPI :8000) ──► PostgreSQL 15
Android (Compose)   ──┘
```

Todos los clientes consumen la misma API REST en `http://localhost:8000`.

---

## Backend (`/Backend`)

**Stack:** Python 3.11 · FastAPI · SQLAlchemy 2 · Alembic · PostgreSQL 15 · uv · Docker

**Arranque:**
```bash
make start      # docker-compose up -d (PostgreSQL + FastAPI)
make migrate    # corre migraciones Alembic
make seed       # carga datos de prueba
make seed-fresh # limpia y recarga datos
```

**Endpoints:**
| Método | Ruta | Descripción |
|--------|------|-------------|
| GET | `/` | Bienvenida |
| GET | `/health` | Estado del servicio + DB |
| GET | `/courses` | Lista de cursos |
| GET | `/courses/{slug}` | Detalle de curso con teachers y clases |

**Estructura:**
```
app/
├── main.py              # Entry point, rutas FastAPI
├── core/config.py       # Settings (Pydantic Settings)
├── db/
│   ├── base.py          # Engine, SessionLocal, get_db()
│   └── seed.py          # Datos de prueba
├── models/
│   ├── base.py          # BaseModel: id, created_at, updated_at, deleted_at
│   ├── course.py        # Course (name, slug, description, thumbnail)
│   ├── teacher.py       # Teacher (name, email)
│   ├── lesson.py        # Lesson (name, slug, video_url, course_id)
│   └── course_teacher.py# Tabla asociativa N:M
├── services/
│   └── course_service.py# Lógica de negocio, retorna dicts según contrato
└── alembic/             # Migraciones DB
specs/
├── 00_contracts.md      # Contratos exactos de respuesta JSON
└── 01_setup.md          # Instrucciones de setup
```

**Modelo de datos:**
```
Course ──< Lesson          (1:N)
Course ──< CourseTeacher >── Teacher  (N:M)
```
Todos los modelos usan soft delete (`deleted_at`). Los cursos se buscan por `slug`, no por `id`.

**Patrones clave:**
- Capas: `main.py` → `CourseService` → `Models` → `DB`
- Inyección de dependencias con `Depends()`
- Los tests en `app/test_main.py` validan contratos estrictamente (no se permiten campos extra)
- Los contratos de respuesta están definidos en `specs/00_contracts.md`

---

## Frontend (`/Frontend`)

**Stack:** Next.js 15.3 · React 19 · TypeScript 5 (strict) · SCSS Modules · Vitest · Yarn

**Arranque:** `yarn dev` (Turbopack, puerto 3000)

**Rutas:**
```
/                        → Home: grid de cursos
/course/[slug]           → Detalle del curso + lista de clases
/classes/[class_id]      → Reproductor de video
```

**Estructura:**
```
src/
├── app/
│   ├── layout.tsx
│   ├── page.tsx                  # Home
│   ├── course/[slug]/
│   │   ├── page.tsx              # Detalle curso
│   │   ├── error.tsx             # "use client" — error boundary
│   │   ├── loading.tsx           # Skeleton
│   │   └── not-found.tsx         # 404
│   └── classes/[class_id]/
│       ├── page.tsx              # Reproductor
│       └── page.test.tsx
├── components/
│   ├── Course/                   # Tarjeta de curso
│   ├── CourseDetail/             # Vista detalle
│   └── VideoPlayer/              # Reproductor de video
├── types/index.ts                # Interfaces TypeScript centralizadas
└── styles/
    ├── vars.scss                 # Tokens: color primario #ff2d2d, grises
    └── reset.scss
```

**Patrones clave:**
- Server Components por defecto; solo `error.tsx` usa `"use client"`
- Fetch sin caché: `fetch(url, { cache: "no-store" })`
- Sin librería de estado (no Redux, Zustand, etc.)
- URL del backend hardcodeada: `http://localhost:8000`
- SCSS Modules para estilos con scope (`*.module.scss`)
- `vars.scss` auto-importado via `next.config.ts`
- Tests con Vitest + Testing Library (jsdom)

---

## Mobile (`/Mobile`)

### iOS (`/Mobile/PlatziFlixiOS`)

**Stack:** Swift · SwiftUI · URLSession · Combine · async/await

**Arquitectura:** Clean Architecture (Domain / Data / Presentation)

```
Domain/
├── Models/          # Course, Teacher, Class (modelos puros)
└── Repositories/    # Protocolo CourseRepository
Data/
├── Entities/        # DTOs: CourseDTO, ClassDTO, TeacherDTO
├── Repositories/    # RemoteCourseRepository (implementación)
└── Mapper/          # CourseMapper, TeacherMapper, ClassMapper
Presentation/
├── ViewModels/      # CourseListViewModel (@MainActor, @Published)
└── Views/           # CourseListView, CourseCardView, DesignSystem
Services/
├── NetworkManager.swift    # URLSession wrapper
├── NetworkService.swift    # Protocolo genérico
├── APIEndpoint.swift       # Protocolo para endpoints
├── NetworkError.swift      # Enum de errores
└── CourseAPIEndpoints.swift# Definición de endpoints
```

**Vistas implementadas:** `CourseListView` (lista con search, refresh, loading/empty states)

**Base URL:** `http://localhost:8000`

---

### Android (`/Mobile/PlatziFlixAndroid`)

**Stack:** Kotlin · Jetpack Compose · Retrofit 2 · OkHttp3 · Coroutines · StateFlow · Coil

**Arquitectura:** Clean Architecture + MVI-like state management

```
di/AppModule.kt              # DI manual
domain/models/               # Course
domain/repositories/         # Interface CourseRepository
data/entities/               # CourseDTO (@SerializedName)
data/repositories/           # RemoteCourseRepository, MockCourseRepository
data/mappers/                # CourseMapper
data/network/                # ApiService (Retrofit), NetworkModule
presentation/courses/
├── viewmodel/               # CourseListViewModel (StateFlow)
├── state/                   # CourseListUiState, CourseListUiEvent
├── screen/                  # CourseListScreen
└── components/              # CourseCard, ErrorMessage, LoadingIndicator
ui/theme/                    # Color, Theme, Type, Spacing
```

**Base URL:** `http://10.0.2.2:8000/` (localhost del emulador Android)

**MockCourseRepository:** 5 cursos falsos, delay de 1.5s, fallo aleatorio del 10% — útil para desarrollo offline.

---

## Flujo de datos (todos los clientes)

```
API JSON → DTO → Mapper → Domain Model → ViewModel → View (declarativa)
```

---

## Convenciones del proyecto

- Los slugs identifican cursos (no los IDs numéricos)
- Todos los modelos del backend tienen soft delete (`deleted_at`)
- Los contratos de respuesta están en `Backend/specs/00_contracts.md` — respetar al hacer cambios en la API
- El backend corre en Docker; frontend y mobile se conectan directamente
- Mensajes de error de la UI en español (iOS y Android)
