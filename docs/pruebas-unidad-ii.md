# Pruebas y evidencias - Unidad II

## Criterios de la practica

- MongoDB: al menos seis documentos de tres tipos de servicio, arreglos y un
  subdocumento; tres filtros, actualizacion, eliminacion, agregacion y
  persistencia.
- Neo4j: al menos cinco estudiantes, cuatro servicios y ocho relaciones;
  tres consultas Cypher, actualizacion y persistencia.
- Cassandra: al menos doce eventos de tres estudiantes, consulta por
  estudiante y periodo, actualizacion, eliminacion y justificacion del modelo.
- Los datos de los tres modulos son ficticios; SQL Server conserva su funcion
  relacional.

## Inventario reproducible

| Motor | Scripts | Salida que debe comprobarse |
|---|---|---|
| MongoDB | `mongodb/01` a `mongodb/06` | Conteo de carga, tres resultados filtrados, valores antes/despues, documento eliminado y conteo por categoria |
| Neo4j | `neo4j/01` a `neo4j/04` | 5 estudiantes, 4 servicios, 10 relaciones, consultas, propiedad actualizada y persistencia |
| Cassandra | `cassandra/01` a `cassandra/06` | 12 inserciones idempotentes, filas del periodo, fila actualizada y eliminada y persistencia |

Los scripts de MongoDB y Cassandra se ejecutan mediante `docker exec`; los de
Neo4j pueden ejecutarse en Neo4j Browser o `cypher-shell`. Los comandos se
encuentran en [`instalacion-unidad-ii.md`](instalacion-unidad-ii.md).

## Resultados observados

Las salidas completas se encuentran en `evidencias/unidad-ii/{mongodb,neo4j,cassandra}/ejecucion-real.txt` y
`evidencias/unidad-ii/generales/persistencia-real.txt`.

- MongoDB: 6 inserciones (`inserted: 6`); tres filtros con 3, 2 y 1
  coincidencias; actualización (`matched: 1`, `modified: 1`); eliminación
  (`deleted: 1`); agregación de 2 servicios académicos, 2 de instalaciones y
  1 de bienestar después de eliminar la beca.
- Neo4j: 5 estudiantes, 4 servicios, 10 relaciones; las tres consultas
  retornaron filas; la actualización produjo canal `web` y satisfacción `5`.
- Cassandra: 12 filas aplicadas; 4 eventos del estudiante EST-1001 antes de la
  eliminación; `UPDATE` visible en la fila; 3 eventos después de eliminar un
  registro.
- Persistencia: después de reiniciar los tres contenedores, los tres quedaron
  `healthy`. MongoDB conservó 5 documentos, capacidad 14 y el documento
  eliminado ausente; Neo4j conservó 5/4/10; Cassandra conservó 3 eventos en
  la partición de EST-1001 para octubre.

La salida muestra registros ficticios y no contiene credenciales. Cassandra
no tiene autenticación CQL habilitada por la imagen oficial de forma
predeterminada; su puerto se limita a loopback. MongoDB y Neo4j se probaron
usando sus credenciales locales sin imprimirlas.

## Capturas pendientes

Los resultados de CLI se guardaron como transcripciones de texto. La rúbrica
solicita además capturas de pantalla; guarda capturas reales de la salida de
los gestores, no capturas del codigo, en `evidencias/unidad-ii/`:

- MongoDB: conexion autenticada, documentos insertados, filtros, actualizacion
  antes/despues, eliminacion, agregacion y persistencia.
- Neo4j: conexion, grafo, tres consultas, actualizacion y persistencia.
- Cassandra: conectividad, keyspace/tabla, carga, consulta de intervalo,
  actualizacion y eliminacion.

No se incluyen capturas simuladas en este repositorio. Anota fecha, servicio,
comando y resultado visible junto con cada captura.
