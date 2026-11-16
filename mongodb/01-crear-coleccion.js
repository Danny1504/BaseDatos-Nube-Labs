const dbCampus = db.getSiblingDB("CampusCloud");
const collectionName = "servicios_extendidos_unidad_ii";

if (!dbCampus.getCollectionNames().includes(collectionName)) {
  dbCampus.createCollection(collectionName);
}

dbCampus[collectionName].createIndex({ serviceId: 1 }, { unique: true });
print(`Coleccion lista: CampusCloud.${collectionName}`);
