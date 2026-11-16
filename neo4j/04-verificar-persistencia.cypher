MATCH (e:Estudiante)
RETURN count(e) AS estudiantesPersistidos;

MATCH (s:Servicio)
RETURN count(s) AS serviciosPersistidos;

MATCH (:Estudiante)-[r:UTILIZA]->(:Servicio)
RETURN count(r) AS relacionesPersistidas;
