const collection = db.getSiblingDB("CampusCloud").servicios_extendidos_unidad_ii;
const id = "CC-SRV-006";

print("Antes:");
printjson(collection.findOne({ _id: id }, { _id: 1, name: 1 }));

const result = collection.deleteOne({ _id: id });
printjson({ deleted: result.deletedCount });

print("Despues:");
printjson(collection.findOne({ _id: id }, { _id: 1, name: 1 }));
