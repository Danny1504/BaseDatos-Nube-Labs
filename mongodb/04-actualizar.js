const collection = db.getSiblingDB("CampusCloud").servicios_extendidos_unidad_ii;
const id = "CC-SRV-003";

print("Antes:");
printjson(collection.findOne({ _id: id }, { _id: 1, capacity: 1 }));

const result = collection.updateOne(
  { _id: id },
  { $set: { capacity: 14, "details.lastReviewed": ISODate("2026-11-15T00:00:00Z") } }
);

printjson({ matched: result.matchedCount, modified: result.modifiedCount });
print("Despues:");
printjson(collection.findOne({ _id: id }, { _id: 1, capacity: 1, details: 1 }));
