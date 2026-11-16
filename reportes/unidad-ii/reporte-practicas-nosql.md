# Reporte técnico: prácticas NoSQL de CampusCloud

**Universidad Tecnológica de Tula-Tepeji**  
**Asignatura:** Bases de Datos en la Nube  
**Unidad II — Actividad de Evaluación 2**  
**Estudiante:** [Nombre del estudiante]  
**Fecha de pruebas:** 15 de noviembre de 2026

## 1. Resumen ejecutivo

Se extendió CampusCloud con MongoDB, Neo4j y Apache Cassandra mediante el
Docker Compose existente. SQL Server conserva los datos relacionales de
estudiantes, servicios y solicitudes; los motores NoSQL atienden casos
especializados sin sustituir ni replicar esas tablas.

Los tres servicios se probaron localmente con datos ficticios. MongoDB
almacenó seis documentos semiestructurados y completó filtros, actualización,
eliminación y agregación. Neo4j persistió cinco estudiantes, cuatro servicios
y diez relaciones, y respondió consultas de uso, coincidencia y recomendación.
Cassandra cargó doce eventos y permitió consultar un estudiante durante un
mes, modificar un registro y eliminar otro. Después de reiniciar los
contenedores, se comprobaron los datos persistidos.

## 2. Problema y selección de modelos

La tabla relacional de servicios describe los datos centrales, pero algunos
atributos de catálogo cambian por tipo de servicio. MongoDB almacena esos
detalles opcionales en documentos con arreglos y subdocumentos, vinculados
mediante `serviceId`.

Las relaciones de uso entre estudiantes y servicios son un grafo. Neo4j
permite recorrerlas para identificar servicios compartidos y recomendar un
servicio que aún no utiliza un estudiante.

La bitácora de actividad requiere leer eventos de un estudiante dentro de un
periodo. Cassandra se modeló desde ese patrón de consulta: su partición
contiene el identificador de estudiante y el mes, y sus claves de
agrupamiento ordenan las marcas de tiempo. No se plantea una consulta general
sin partición ni un clúster de producción.

## 3. Arquitectura y despliegue

```text
                         Docker Compose
       ┌──────────────────────┼──────────────────────────┐
       │                      │                          │
  SQL Server             MongoDB                     Neo4j
  tablas relacionales    documentos de servicio      estudiantes
                                                    -[UTILIZA]->
                                                       servicios
                              │                           │
                              └──────────┬────────────────┘
                                         │
                                     Cassandra
                              eventos por estudiante/mes
```

El Compose integrado conserva PostgreSQL, pgAdmin, SQL Server, MongoDB y
Neo4j, y añade Cassandra 5.0.9. Los datos se guardan en volúmenes separados;
el volumen `cassandra_data` se monta en `/var/lib/cassandra`. El puerto CQL se
publica solo en `127.0.0.1:9042`; MongoDB y Neo4j utilizan sus puertos y
credenciales locales ya definidos en el entorno. Los servicios comparten la
red Docker externa declarada por `DOCKER_NETWORK`.

Los archivos `.env.example` contienen valores ilustrativos. Las contraseñas
locales permanecen en `.env`, ignorado por Git, y no forman parte de los
scripts ni de la evidencia. No se incorporó API, proxy, clúster ni despliegue
cloud.

## 4. MongoDB: documentos de servicios

Se creó `CampusCloud.servicios_extendidos_unidad_ii`, con un índice único
sobre `serviceId`. Cada documento referencia un servicio relacional y
almacena su categoría, días disponibles y requisitos en arreglos, además de
modalidad y tiempo de atención en el subdocumento `details`.

La carga verificó seis documentos ficticios en tres categorías. Tres filtros
independientes encontraron: 3 documentos académicos, 2 de modalidad digital
y 1 con etiqueta de laboratorio. La actualización controlada cambió la
capacidad de `CC-SRV-003` de 12 a 14 (`matched: 1`, `modified: 1`). La
eliminación por `_id` afectó un documento (`deleted: 1`). La agregación por
categoría produjo 2 servicios académicos, 2 de instalaciones y 1 de
bienestar, con capacidades promedio 57, 27 y 8, respectivamente.

Tras reiniciar MongoDB, la consulta de persistencia encontró cinco documentos,
conservó capacidad 14 y confirmó que el documento eliminado seguía ausente.
Los scripts están en `mongodb/01` a `mongodb/07`; la salida completa está en
`evidencias/unidad-ii/mongodb/ejecucion-real.txt` y
`evidencias/unidad-ii/generales/persistencia-real.txt`.

## 5. Neo4j: grafo de estudiantes y servicios

El modelo creó cinco nodos `Estudiante`, cuatro nodos `Servicio` y diez
relaciones `UTILIZA`, cada una con una fecha. Los identificadores y nombres
son ficticios. Las consultas Cypher mostraron los servicios usados por
EST-1001, pares de estudiantes que comparten un servicio y recomendaciones
basadas en estudiantes con actividad relacionada. Para EST-1001 se
recomendaron el préstamo de laboratorio y la sala de estudio.

La actualización añadió `channel = 'web'` y `rating = 5` a una relación
existente. Después del reinicio se conservaron los cinco estudiantes, cuatro
servicios y diez relaciones. Los archivos `neo4j/01` a `neo4j/04` contienen
la carga, consultas, actualización y verificación; su salida está en
`evidencias/unidad-ii/neo4j/ejecucion-real.txt` y
`evidencias/unidad-ii/generales/persistencia-real.txt`.

## 6. Cassandra: eventos por estudiante y mes

El keyspace `campuscloud_events` usa `SimpleStrategy` con factor de
replicación 1 porque esta es una instancia local de un solo nodo. La tabla
`events_by_student_month` tiene partition key `(student_id, event_month)` y
clustering `(event_ts, event_id)`. Así, una lectura por estudiante/mes y
rango temporal se dirige a una partición conocida. No se admiten consultas
eficientes que omitan esas claves.

Se insertaron doce eventos ficticios, cuatro para cada uno de tres
estudiantes. Para EST-1001 en octubre de 2026, la consulta inicial encontró
cuatro eventos. Un `UPDATE` cambió el tipo del evento de constancia y añadió
un valor a `metadata`; un `DELETE` eliminó el evento de tutoría. La consulta
final y la verificación tras reiniciar encontraron tres eventos.

La imagen oficial de Cassandra no habilita autenticación CQL por defecto en
esta configuración. Por ello, el puerto se limita a loopback y se documenta
que no debe exponerse a una red compartida. Los scripts `cassandra/01` a
`cassandra/06` y la salida en `evidencias/unidad-ii/cassandra/ejecucion-real.txt`
permiten repetir y revisar las operaciones.

## 7. Seguridad, persistencia e incidencia

MongoDB y Neo4j se ejecutaron autenticando con los valores del entorno del
contenedor; estos valores no se imprimieron ni quedaron en los scripts. Las
plantillas incluyen solo valores de ejemplo y `.env` se excluye por
`.gitignore`. Cassandra no ofrece autenticación en este ejemplo; el límite de
red en loopback reduce el acceso al equipo local, pero no reemplaza un control
de usuarios para un servicio compartido.

Se reiniciaron los tres contenedores y se esperó el estado `healthy` antes de
consultar de nuevo los datos. MongoDB conservó la actualización y eliminación,
Neo4j conservó nodos y relaciones, y Cassandra conservó la partición de
eventos restante.

Durante la primera prueba de Neo4j, `cypher-shell` no se encontró porque el
shell de inicio de sesión `sh -lc` restableció el `PATH` de la imagen. Se
comprobó la ruta de la herramienta y se corrigió el comando a `sh -c`; la
repetición produjo los conteos y resultados esperados.

Las transcripciones de salida muestran ejecución real, no datos inventados.
Las capturas de pantalla de interfaz solicitadas por la rúbrica deben
agregarse en `evidencias/unidad-ii/` antes de entregar; este reporte no las
presenta como si ya existieran.

## 8. Comparación local/cloud y conclusiones

Docker local facilita aprender instalación y persistencia, pero el alumno
administra host, red, actualización del motor, respaldos, recuperación y
disponibilidad. En AWS hay alternativas administradas distintas por modelo:
DocumentDB (compatibilidad MongoDB), Neptune (grafos y openCypher) y
Keyspaces (Cassandra/CQL). Azure Cosmos DB ofrece APIs para MongoDB,
Gremlin y Cassandra, con compatibilidad y lenguajes distintos. Google Cloud
Bigtable cubre ciertos patrones wide-column pero no es una API Cassandra;
Atlas y AuraDB son opciones de proveedores especializados que pueden
desplegarse en infraestructura cloud. Ninguna de estas opciones debe
considerarse reemplazo directo sin validar drivers, consultas, operaciones,
costos y seguridad.

En un servicio administrado el proveedor opera parte de la infraestructura,
plataforma, parches y mecanismos de disponibilidad según el producto. El
cliente conserva responsabilidad sobre los datos, el modelo, permisos,
exposición de red, secretos, retención, configuración y pruebas de
restauración. La matriz y referencias se detallan en
`docs/comparacion-cloud-local.md`.

Las pruebas comprobaron que cada modelo cubre un patrón distinto y que los
scripts son repetibles. Para un entorno real habría que reforzar la
autenticación de Cassandra, implementar copias fuera del host, medir
capacidad, definir políticas de retención y revisar compatibilidad antes de
migrar a un servicio cloud.

## Referencias

1. Universidad Tecnológica de Tula-Tepeji. *Actividad de Evaluación 2 —
   Unidad II: Operación CampusCloud*, documento proporcionado para la misión.
2. Universidad Tecnológica de Tula-Tepeji. *Guía de organización del
   repositorio CampusCloud — Unidad II*, documento proporcionado para la
   misión.
3. AWS. [Amazon DocumentDB](https://docs.aws.amazon.com/documentdb/latest/devguide/what-is.html),
   [Amazon Neptune](https://docs.aws.amazon.com/neptune/latest/userguide/intro.html)
   y [Amazon Keyspaces](https://docs.aws.amazon.com/keyspaces/latest/devguide/what-is-keyspaces.html).
4. Microsoft. [Cosmos DB for MongoDB](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/overview),
   [Apache Gremlin](https://learn.microsoft.com/en-us/azure/cosmos-db/gremlin/overview)
   y [Apache Cassandra](https://learn.microsoft.com/en-us/azure/cosmos-db/cassandra/overview).
5. Google Cloud. [Cloud Bigtable overview](https://cloud.google.com/bigtable/docs/overview).
6. MongoDB. [MongoDB Atlas](https://www.mongodb.com/products/platform).
7. Neo4j. [AuraDB](https://neo4j.com/product/auradb/).
