# CampusCloud - practicas NoSQL de Unidad II

Este paquete complementa SQL Server con MongoDB, Neo4j y Apache Cassandra.
Los registros son ficticios. No incluye API REST ni `api/`.

## Contenido

- `01-configuracion/`: Compose integrado y plantilla de entorno sin secretos.
- `02-mongodb/`: scripts de documentos, filtros, CRUD, agregacion y persistencia.
- `03-neo4j/`: carga de nodos/aristas, consultas Cypher, actualizacion y persistencia.
- `04-columnas-anchas/cassandra/`: esquema, doce eventos CQL y operaciones.
- `05-evidencias/`: transcripciones reales de las ejecuciones locales y guia
  para agregar capturas de pantalla.
- `06-documentacion/`: instalacion, arquitectura, pruebas, bitacora y
  comparacion cloud/local.

## Requisitos

- Docker Desktop y Docker Compose.
- Crear un archivo `.env` local a partir de
  `01-configuracion/.env.example`; reemplazar todos los valores ficticios y no
  compartir el `.env`.
- Crear la red externa cuyo nombre figure en `DOCKER_NETWORK`, si no existe.

## Ejecucion

Desde PowerShell, en la raiz del paquete:

```powershell
docker compose --env-file .\.env -f .\01-configuracion\compose.yaml config --quiet
docker compose --env-file .\.env -f .\01-configuracion\compose.yaml up -d mongodb neo4j
docker compose --env-file .\.env -f .\01-configuracion\compose.yaml up -d cassandra
docker compose --env-file .\.env -f .\01-configuracion\compose.yaml ps
```

Consulta `06-documentacion/instalacion-unidad-ii.md` para ejecutar los scripts,
autenticarse y comprobar persistencia. Cassandra usa por defecto CQL sin
autenticacion; su puerto se limita a loopback y no debe exponerse a una red.
Los volúmenes mantienen los datos al detener y volver a iniciar los servicios.
No uses `down -v` durante las pruebas de persistencia.

Las transcripciones prueban que se ejecutaron consultas reales. Agrega las
capturas de pantalla exigidas por la rúbrica en `05-evidencias/` antes de
entregar.
