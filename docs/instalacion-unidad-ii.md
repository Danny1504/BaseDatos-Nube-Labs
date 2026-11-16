# Instalacion y ejecucion - Unidad II

Todos los comandos se ejecutan en PowerShell desde la raiz del repositorio.
El procedimiento utiliza el Compose existente en `campus-cloud-project/` y no
inicia `api/`.

## Preparar el entorno

1. Copia `campus-cloud-project/.env.example` como
   `campus-cloud-project/.env`.
2. Sustituye los valores ficticios por valores locales fuertes y unicos.
   No compartas ni agregues el archivo `.env` a Git.
3. Conserva la red Docker externa declarada por `DOCKER_NETWORK`. El Compose
   actual la necesita para sus servicios.
4. Comprueba la configuracion sin mostrarla:

```powershell
docker compose --env-file .\campus-cloud-project\.env -f .\campus-cloud-project\docker-compose.yml config --quiet
```

## Iniciar servicios

No es necesario iniciar toda la plataforma. Los siguientes comandos levantan
solo los motores de estas practicas:

```powershell
$compose = ".\campus-cloud-project\docker-compose.yml"
$envFile = ".\campus-cloud-project\.env"
docker compose --env-file $envFile -f $compose up -d mongodb neo4j
docker compose --env-file $envFile -f $compose up -d cassandra
docker compose --env-file $envFile -f $compose ps
```

Espera a que MongoDB, Neo4j y Cassandra indiquen estado saludable o disponible.
Cassandra puede tardar varios minutos en su primer arranque.

## MongoDB

La imagen requiere el usuario root del Compose y autentica contra `admin`. El
comando lee esas variables dentro del contenedor, por lo que la contrasena no
se escribe en el script ni en la linea de comandos:

```powershell
Get-Content -Raw .\mongodb\01-crear-coleccion.js | docker exec -i CampCloud-mongodb sh -lc 'mongosh --quiet --username "$MONGO_INITDB_ROOT_USERNAME" --password "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase admin'
```

Repite el comando cambiando el archivo por cada script numerado de
`mongodb/`. Ejecuta `01` a `06` en orden; el script `07` verifica la
persistencia despues de reiniciar el contenedor. La carga usa upsert para que
los seis documentos de practica sean repetibles.

## Neo4j

Neo4j expone Browser en `http://localhost:7474` y Bolt en `localhost:7687`.
Usa el usuario y la contrasena definidos localmente en `NEO4J_AUTH`. No los
copies a los scripts ni a las capturas. En Neo4j Browser ejecuta los archivos
`.cypher` `01` a `03`; `04` verifica la persistencia tras reiniciar.
`01-crear-nodos-relaciones.cypher` termina con conteos de estudiantes,
servicios y relaciones.

Para ejecutar un archivo desde PowerShell sin incluir la contrasena en el
comando:

```powershell
Get-Content -Raw .\neo4j\01-crear-nodos-relaciones.cypher | docker exec -i CampCloud-neo4j sh -c 'auth="$NEO4J_AUTH"; user="${auth%%/*}"; password="${auth#*/}"; cypher-shell --non-interactive -u "$user" -p "$password"'
```

Repite para los otros archivos `.cypher`. Se usa `sh -c` para conservar el
`PATH` de la imagen, donde se encuentra `cypher-shell`.

## Cassandra

Cassandra expone CQL en `127.0.0.1:9042` para limitar el acceso al equipo local.
La imagen oficial se configura sin autenticacion CQL por defecto; por eso esta
practica limita el puerto a localhost y no debe publicarse en una red compartida.
Para ejecutar un archivo desde PowerShell:

```powershell
Get-Content -Raw .\cassandra\01-crear-keyspace-tabla.cql | docker exec -i CampCloud-cassandra cqlsh
```

Ejecuta los archivos `01` a `05` en orden. El archivo `06` verifica la
persistencia tras reiniciar. Los scripts crean el keyspace y la
tabla, insertan doce eventos, consultan por estudiante/mes y aplican un
`UPDATE` y un `DELETE` con todas las columnas de la clave primaria.

## Persistencia y limpieza

Para comprobar persistencia, registra un conteo, detiene e inicia el servicio,
y vuelve a ejecutar la consulta:

```powershell
docker compose --env-file $envFile -f $compose stop cassandra
docker compose --env-file $envFile -f $compose start cassandra
docker compose --env-file $envFile -f $compose ps
```

Los volumenes `mongo_data`, `neo4j_data` y `cassandra_data` mantienen los datos
al detener/reiniciar contenedores. No uses `down -v` durante esa prueba.

Para detener servicios sin borrar datos:

```powershell
docker compose --env-file $envFile -f $compose stop mongodb neo4j cassandra
```
