const collection = db.getSiblingDB("CampusCloud").servicios_extendidos_unidad_ii;

print("Filtro 1: categoria academico");
printjson(collection.find(
  { category: "academico" },
  { _id: 1, name: 1, category: 1 }
).sort({ serviceId: 1 }).toArray());

print("Filtro 2: modalidad digital");
printjson(collection.find(
  { "details.modality": "digital" },
  { _id: 1, name: 1, "details.modality": 1 }
).sort({ serviceId: 1 }).toArray());

print("Filtro 3: etiqueta laboratorio");
printjson(collection.find(
  { tags: "laboratorio" },
  { _id: 1, name: 1, tags: 1 }
).toArray());
