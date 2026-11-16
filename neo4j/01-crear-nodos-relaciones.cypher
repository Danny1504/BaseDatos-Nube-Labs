UNWIND [
  {studentId: 'EST-1001', name: 'Ana Torres', program: 'Sistemas'},
  {studentId: 'EST-1002', name: 'Luis Vega', program: 'Redes'},
  {studentId: 'EST-1003', name: 'Mia Cruz', program: 'Sistemas'},
  {studentId: 'EST-1004', name: 'Leo Rios', program: 'Industrial'},
  {studentId: 'EST-1005', name: 'Eva Solis', program: 'Redes'}
] AS row
MERGE (e:Estudiante {studentId: row.studentId})
SET e.name = row.name, e.program = row.program;

UNWIND [
  {serviceId: 'SRV-001', name: 'Constancia de estudios', category: 'academico'},
  {serviceId: 'SRV-002', name: 'Prestamo de laboratorio', category: 'instalaciones'},
  {serviceId: 'SRV-003', name: 'Asesoria de matematicas', category: 'academico'},
  {serviceId: 'SRV-004', name: 'Sala de estudio', category: 'instalaciones'}
] AS row
MERGE (s:Servicio {serviceId: row.serviceId})
SET s.name = row.name, s.category = row.category;

UNWIND [
  {studentId: 'EST-1001', serviceId: 'SRV-001', since: '2026-10-01'},
  {studentId: 'EST-1001', serviceId: 'SRV-003', since: '2026-10-03'},
  {studentId: 'EST-1002', serviceId: 'SRV-001', since: '2026-10-02'},
  {studentId: 'EST-1002', serviceId: 'SRV-002', since: '2026-10-04'},
  {studentId: 'EST-1003', serviceId: 'SRV-003', since: '2026-10-05'},
  {studentId: 'EST-1003', serviceId: 'SRV-004', since: '2026-10-07'},
  {studentId: 'EST-1004', serviceId: 'SRV-002', since: '2026-10-08'},
  {studentId: 'EST-1004', serviceId: 'SRV-004', since: '2026-10-09'},
  {studentId: 'EST-1005', serviceId: 'SRV-001', since: '2026-10-10'},
  {studentId: 'EST-1005', serviceId: 'SRV-003', since: '2026-10-11'}
] AS row
MATCH (e:Estudiante {studentId: row.studentId})
MATCH (s:Servicio {serviceId: row.serviceId})
MERGE (e)-[r:UTILIZA]->(s)
SET r.since = date(row.since);

MATCH (e:Estudiante)
RETURN count(e) AS estudiantes;

MATCH (s:Servicio)
RETURN count(s) AS servicios;

MATCH (:Estudiante)-[r:UTILIZA]->(:Servicio)
RETURN count(r) AS relaciones;
