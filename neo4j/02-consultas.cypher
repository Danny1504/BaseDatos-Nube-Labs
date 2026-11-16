// Servicios utilizados por un estudiante ficticio.
MATCH (:Estudiante {studentId: 'EST-1001'})-[r:UTILIZA]->(s:Servicio)
RETURN s.serviceId AS servicioId, s.name AS servicio, r.since AS desde
ORDER BY servicioId;

// Estudiantes que comparten un servicio.
MATCH (e:Estudiante)-[:UTILIZA]->(s:Servicio)<-[:UTILIZA]-(otro:Estudiante)
WHERE e.studentId < otro.studentId
RETURN s.name AS servicio, e.name AS estudianteA, otro.name AS estudianteB
ORDER BY servicio, estudianteA;

// Recomendaciones basadas en servicios compartidos por otros estudiantes.
MATCH (objetivo:Estudiante {studentId: 'EST-1001'})-[:UTILIZA]->(:Servicio)
      <-[:UTILIZA]-(similar:Estudiante)-[:UTILIZA]->(recomendado:Servicio)
WHERE similar <> objetivo
  AND NOT (objetivo)-[:UTILIZA]->(recomendado)
RETURN recomendado.name AS recomendacion,
       count(DISTINCT similar) AS estudiantesQueLaUsan
ORDER BY estudiantesQueLaUsan DESC, recomendacion;
