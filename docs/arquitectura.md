# Arquitectura de CampusCloud - Unidad II

## Proposito

CampusCloud conserva SQL Server como registro relacional de estudiantes,
servicios y solicitudes. MongoDB, Neo4j y Cassandra se agregan como almacenes
especializados para tres necesidades distintas; no sustituyen SQL Server ni
duplican sus tablas transaccionales.

## Vista logica

```text
                         Docker Compose
       ┌──────────────────────┼──────────────────────────┐
       │                      │                          │
  SQL Server             MongoDB                     Neo4j
  estudiantes,           detalles flexibles           estudiantes
  servicios y            de servicios                 -[UTILIZA]->
  solicitudes                                           servicios
       │                      │                          │
       └──────────────────────┴──────────────┬───────────┘
                                             │
                                         Cassandra
                                  eventos por estudiante/mes
```

Los servicios comparten la red Docker externa configurada por
`DOCKER_NETWORK`. Cada motor tiene almacenamiento persistente en un volumen
separado. Cassandra publica CQL solo en `127.0.0.1:9042`; MongoDB y Neo4j
conservan los puertos definidos por el Compose y sus credenciales locales.

## Modelos y datos

| Motor | Uso en CampusCloud | Clave o referencia |
|---|---|---|
| SQL Server | Datos relacionales de Unidad I y solicitudes transaccionales | `Estudiantes`, `Servicios`, `Solicitudes` |
| MongoDB | Atributos variables de seis servicios ficticios, incluidos arreglos y subdocumentos | `serviceId` referencia el servicio relacional; la coleccion de practica es independiente |
| Neo4j | Relaciones entre cinco estudiantes ficticios y cuatro servicios | `Estudiante.studentId`, `Servicio.serviceId`, relacion `UTILIZA` |
| Cassandra | Bitacora ficticia consultada por estudiante y mes | Partition key `(student_id, event_month)`; clustering por `event_ts` y `event_id` |

La clave de particion de Cassandra dirige todas las consultas al estudiante y
al mes solicitados. El ordenamiento por marca de tiempo permite leer un
intervalo dentro de esa particion; consultas sin ambas partes de la clave no
son parte del patron soportado y requeririan otro modelo o indice.

## Limites de despliegue

El Compose integrado tambien contiene PostgreSQL, pgAdmin y SQL Server porque
pertenecen al avance previo del proyecto. Las practicas no requieren iniciar
todos los servicios a la vez. No se incorpora API, cluster de Cassandra ni
configuracion de nube en esta unidad. El detalle de ejecucion esta en
[`instalacion-unidad-ii.md`](instalacion-unidad-ii.md).
