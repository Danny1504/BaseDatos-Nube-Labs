MATCH (:Estudiante {studentId: 'EST-1001'})-[r:UTILIZA]->(:Servicio {serviceId: 'SRV-001'})
RETURN r.since AS fecha, r.channel AS canal, r.rating AS satisfaccion;

MATCH (:Estudiante {studentId: 'EST-1001'})-[r:UTILIZA]->(:Servicio {serviceId: 'SRV-001'})
SET r.channel = 'web', r.rating = 5
RETURN r.since AS fecha, r.channel AS canal, r.rating AS satisfaccion;
