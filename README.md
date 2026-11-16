# CampusCloud

Proyecto académico de la asignatura Bases de Datos en la Nube.

## Objetivo

Construir progresivamente una Nube Académica Local que permita comprender:

- bases de datos relacionales;
- bases de datos NoSQL;
- persistencia;
- usuarios, roles y privilegios;
- conexión local y remota;
- integración mediante API;
- Docker y Docker Compose como herramientas de soporte.

## Unidad I

Primera implementación:

PC → Docker → SQL Server → Volumen → CampusCloud

Tecnología inicial:

- Docker Desktop
- SQL Server 2025
- Cliente SQL
- Git
- Visual Studio Code

## Unidad II: practicas NoSQL

La Unidad II complementa SQL Server con tres modelos especializados: MongoDB
para detalles flexibles de servicios, Neo4j para relaciones entre estudiantes y
servicios, y Cassandra para consultar eventos por estudiante y mes. Los datos
de estas practicas son ficticios y no reemplazan las tablas relacionales.

### Requisitos y configuracion

- Docker Desktop con Docker Compose.
- PowerShell desde la raiz del repositorio.
- Un archivo local `campus-cloud-project/.env`, creado a partir de
  `campus-cloud-project/.env.example`. Cambia todos los valores ficticios y no
  publiques el `.env`.
- La red externa declarada por `DOCKER_NETWORK` debe existir. Si ya ejecutas el
  Compose de CampusCloud, conserva su red y sus contenedores actuales.

Los scripts y procedimientos estan en [mongodb/](mongodb/),
[neo4j/](neo4j/) y [cassandra/](cassandra/). La configuracion y el registro de
pruebas se describen en [docs/instalacion-unidad-ii.md](docs/instalacion-unidad-ii.md),
[docs/arquitectura.md](docs/arquitectura.md) y
[docs/bitacora.md](docs/bitacora.md).

### Iniciar y detener

```powershell
docker compose --env-file .\campus-cloud-project\.env -f .\campus-cloud-project\docker-compose.yml up -d mongodb neo4j
docker compose --env-file .\campus-cloud-project\.env -f .\campus-cloud-project\docker-compose.yml up -d cassandra
docker ps
```

Consulta los pasos para autenticarse y ejecutar cada archivo en
[docs/instalacion-unidad-ii.md](docs/instalacion-unidad-ii.md). Para detener
un gestor sin borrar sus datos:

```powershell
docker compose --env-file .\campus-cloud-project\.env -f .\campus-cloud-project\docker-compose.yml stop cassandra
```

Los datos se conservan en volúmenes Docker