const collection = db.getSiblingDB("CampusCloud").servicios_extendidos_unidad_ii;

printjson(collection.aggregate([
  { $match: { _id: /^CC-SRV-/ } },
  {
    $group: {
      _id: "$category",
      services: { $sum: 1 },
      averageCapacity: { $avg: "$capacity" }
    }
  },
  { $sort: { _id: 1 } }
]).toArray());
