# Comparacion de despliegue local y servicios cloud

## Escenario local de esta practica

CampusCloud utiliza Docker Compose en un equipo Windows. Este montaje es
reproducible y apropiado para aprendizaje, pero el alumno administra el
host, Docker Desktop, las redes, los puertos, los volumenes, las credenciales,
las actualizaciones, el monitoreo y las copias/restauraciones. Un volumen local
no sustituye una estrategia de respaldo fuera del equipo.

La configuracion es de un solo nodo para MongoDB, Neo4j y Cassandra. No ofrece
por si sola alta disponibilidad, tolerancia a la perdida del host, escalado
administrado ni un SLA.

## Alternativas cloud (no equivalencias exactas)

| Proveedor | Documentos | Grafos | Columnas anchas |
|---|---|---|---|
| AWS | Amazon DocumentDB ofrece compatibilidad con MongoDB; conviene validar las diferencias de versiones y funciones antes de migrar. | Amazon Neptune admite openCypher, Gremlin y SPARQL; no es una instalacion administrada de Neo4j. | Amazon Keyspaces es un servicio administrado compatible con Apache Cassandra y CQL. |
| Microsoft Azure | Azure Cosmos DB for MongoDB ofrece compatibilidad de protocolo/API; la compatibilidad y las capacidades dependen de la API elegida. | Azure Cosmos DB for Apache Gremlin usa Gremlin; una aplicacion Cypher de Neo4j no se migra sin cambios. | Azure Cosmos DB for Apache Cassandra ofrece API y CQL para cargas compatibles; Azure Managed Instance for Apache Cassandra es otra alternativa de migracion/administracion. |
| Google Cloud | MongoDB Atlas puede usarse como servicio del proveedor de MongoDB en una region de Google Cloud; no es un motor MongoDB operado directamente por Google. | Neo4j AuraDB es una alternativa administrada por Neo4j; otra opcion es auto-administrar Neo4j en infraestructura cloud. | Cloud Bigtable ofrece almacenamiento wide-column y administracion del servicio, pero usa su propio modelo/API y no es una interfaz Cassandra/CQL compatible. |

La eleccion debe considerar compatibilidad de consultas, drivers, migracion,
regiones, latencia, seguridad, disponibilidad, costos y dependencia del
proveedor. Que dos productos pertenezcan a la categoria NoSQL no implica que
sean reemplazos directos.

## Responsabilidades

| Area | Despliegue local con Docker | Servicio administrado cloud |
|---|---|---|
| Hardware, hipervisor y disponibilidad fisica | Responsabilidad del propietario del equipo | Principalmente del proveedor, segun el servicio contratado |
| Sistema operativo del host / nodos | Propietario del equipo actualiza y protege el host | Proveedor administra la infraestructura; el alcance de sistema operativo depende del servicio (DBaaS frente a VM) |
| Motor, parches y mantenimiento | Estudiante administra imagen, version y reinicios | Proveedor administra gran parte del motor/plataforma; cliente planifica ventanas y compatibilidad |
| Red y acceso | Estudiante restringe puertos, red Docker y acceso local | Cliente configura VPC/VNet, reglas de firewall, endpoints privados, identidades y accesos |
| Datos y esquema | Estudiante define el modelo, consultas y retencion | Cliente sigue siendo responsable del modelo, calidad, clasificacion, retencion y borrado |
| Credenciales y permisos | Estudiante protege `.env` y usuarios | Cliente administra identidades, roles, rotacion y secretos; el proveedor entrega mecanismos de control |
| Copias y recuperacion | Estudiante diseña, guarda fuera del host y prueba restauraciones | El servicio puede ofrecer copias administradas, pero cliente configura retencion y valida restauraciones segun el plan |
| Costos y observabilidad | Estudiante observa recursos locales | Cliente configura presupuestos/alertas y revisa metricas; el proveedor ofrece telemetria del servicio |

Un DBaaS reduce tareas operativas, pero no elimina la responsabilidad del
cliente sobre datos, autorizaciones, configuracion y uso seguro.

## Fuentes oficiales consultadas

- AWS, [Amazon DocumentDB](https://docs.aws.amazon.com/documentdb/latest/devguide/what-is.html).
- AWS, [Amazon Neptune](https://docs.aws.amazon.com/neptune/latest/userguide/intro.html).
- AWS, [Amazon Keyspaces for Apache Cassandra](https://docs.aws.amazon.com/keyspaces/latest/devguide/what-is-keyspaces.html).
- Microsoft, [Azure Cosmos DB for MongoDB](https://learn.microsoft.com/en-us/azure/cosmos-db/mongodb/overview).
- Microsoft, [Azure Cosmos DB for Apache Gremlin](https://learn.microsoft.com/en-us/azure/cosmos-db/gremlin/overview).
- Microsoft, [Azure Cosmos DB for Apache Cassandra](https://learn.microsoft.com/en-us/azure/cosmos-db/cassandra/overview).
- Google Cloud, [Cloud Bigtable overview](https://cloud.google.com/bigtable/docs/overview).
- MongoDB, [MongoDB Atlas](https://www.mongodb.com/products/platform).
- Neo4j, [AuraDB](https://neo4j.com/product/auradb/).

Las paginas se consultaron el 15 de noviembre de 2026. Las capacidades,
precios, regiones y condiciones pueden cambiar; verifica la documentacion del
producto y del plan antes de una migracion.
