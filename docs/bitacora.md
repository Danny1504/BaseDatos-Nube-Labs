# Bitacora de practicas NoSQL

## Alcance

Registro de la implementacion de MongoDB, Neo4j y Cassandra para Unidad II.
La fecha de esta bitacora corresponde al entorno de desarrollo y no pretende
reemplazar las evidencias de ejecucion que se anexaran al reporte.

## Preparacion

- Se reviso la Actividad de Evaluacion 2 y su guia de organizacion.
- Se eligio Cassandra como motor de columnas anchas; no se agrega ScyllaDB.
- Se conservaron los servicios existentes y se agrego Cassandra al Compose
  integrado con un volumen propio y el puerto CQL limitado a localhost.
- Se prepararon ejemplos `.env.example` sin credenciales reales; los valores
  locales de `.env` no se copian a este repositorio ni al paquete.
- Se excluyo `api/` del alcance de estas practicas, conforme a la separacion
  de unidades indicada para CampusCloud.

## Operaciones y comprobaciones

Se ejecutaron los scripts contra los contenedores locales autenticados de
MongoDB y Neo4j, y contra el contenedor Cassandra. Las salidas completas,
generadas por los comandos, se conservaron en `evidencias/unidad-ii/`.

- MongoDB insertó 6 documentos; devolvio resultados para 3 filtros;
  actualizó capacidad de 12 a 14; eliminó un documento (`deleted: 1`); y la
  agregación contó 2 servicios en cada una de las categorías restantes y 1 en
  bienestar. Tras reiniciar, permanecieron 5 documentos, el valor 14 y la
  eliminación.
- Neo4j devolvio 5 estudiantes, 4 servicios y 10 relaciones. Las consultas de
  uso, servicios compartidos y recomendación produjeron resultados; la
  relación de EST-1001 con SRV-001 se actualizó con canal `web` y satisfacción
  5. Tras reiniciar, se conservaron los 5/4/10.
- Cassandra aplicó 12 inserciones; la consulta inicial encontró 4 eventos
  para EST-1001 dentro de octubre de 2026. Se actualizó un evento y se eliminó
  otro; tras reiniciar, la consulta devolvió 3 eventos en esa partición.

## Incidencia resuelta

La primera ejecución de `cypher-shell` falló con `not found` porque se lanzó
mediante `sh -lc`, que restableció el `PATH` de inicio de sesión del
contenedor. Se comprobó la ruta de la herramienta y se repitió el comando con
`sh -c`, que conserva el entorno de la imagen; las cuatro consultas Cypher
finalizaron correctamente.

La bitácora de resultados detallados está en
[`pruebas-unidad-ii.md`](pruebas-unidad-ii.md).
