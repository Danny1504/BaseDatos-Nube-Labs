const collection = db.getSiblingDB("CampusCloud").servicios_extendidos_unidad_ii;
const documents = [
  {
    _id: "CC-SRV-001",
    serviceId: 1,
    name: "Constancia de estudios",
    category: "academico",
    availableDays: ["lunes", "martes", "miercoles", "jueves", "viernes"],
    requirements: ["matricula_activa", "identificacion"],
    details: { modality: "digital", processingHours: 24 },
    capacity: 100,
    tags: ["documentos", "control_escolar"]
  },
  {
    _id: "CC-SRV-002",
    serviceId: 2,
    name: "Prestamo de laboratorio",
    category: "instalaciones",
    availableDays: ["lunes", "miercoles", "viernes"],
    requirements: ["reserva", "credencial"],
    details: { modality: "presencial", processingHours: 2 },
    capacity: 24,
    tags: ["laboratorio", "equipo"]
  },
  {
    _id: "CC-SRV-003",
    serviceId: 3,
    name: "Asesoria de matematicas",
    category: "academico",
    availableDays: ["martes", "jueves"],
    requirements: ["registro"],
    details: { modality: "hibrida", processingHours: 48 },
    capacity: 12,
    tags: ["tutoria", "matematicas"]
  },
  {
    _id: "CC-SRV-004",
    serviceId: 4,
    name: "Sala de estudio",
    category: "instalaciones",
    availableDays: ["lunes", "martes", "miercoles", "jueves", "viernes"],
    requirements: ["credencial"],
    details: { modality: "presencial", processingHours: 1 },
    capacity: 30,
    tags: ["biblioteca", "estudio"]
  },
  {
    _id: "CC-SRV-005",
    serviceId: 5,
    name: "Orientacion estudiantil",
    category: "bienestar",
    availableDays: ["lunes", "jueves"],
    requirements: ["cita"],
    details: { modality: "privada", processingHours: 72 },
    capacity: 8,
    tags: ["orientacion", "acompanamiento"]
  },
  {
    _id: "CC-SRV-006",
    serviceId: 6,
    name: "Convocatoria de becas",
    category: "academico",
    availableDays: ["lunes", "martes", "miercoles", "jueves", "viernes"],
    requirements: ["solicitud", "comprobante_de_estudios"],
    details: { modality: "digital", processingHours: 120 },
    capacity: 50,
    tags: ["becas", "convocatorias"]
  }
];

const result = collection.bulkWrite(
  documents.map((document) => ({
    replaceOne: {
      filter: { _id: document._id },
      replacement: document,
      upsert: true
    }
  }))
);

printjson({
  matched: result.matchedCount,
  modified: result.modifiedCount,
  inserted: result.upsertedCount,
  totalMissionDocuments: collection.countDocuments({ _id: /^CC-SRV-/ })
});
