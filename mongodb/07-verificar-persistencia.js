const collection = db.getSiblingDB("CampusCloud").servicios_extendidos_unidad_ii;

printjson({
  missionDocumentsAfterRestart: collection.countDocuments({ _id: /^CC-SRV-/ }),
  updatedCapacity: collection.findOne(
    { _id: "CC-SRV-003" },
    { _id: 1, capacity: 1 }
  ),
  deletedDocument: collection.findOne(
    { _id: "CC-SRV-006" },
    { _id: 1 }
  )
});
