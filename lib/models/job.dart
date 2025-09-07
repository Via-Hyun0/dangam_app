import 'package:flutter/material.dart';

enum JobType {
  fruitPicking,
  vegetableHarvest,
  pruning,
  planting,
  weeding,
  irrigationSetup,
  pesticideSpray,
  fertilizerApply,
  soilPreparation,
  tractorMowing,
  baling,
  seeding,
  transplanting,
  greenhouseWork,
  packingSorting,
  orchardMaintenance,
  vineyardTrellising,
  fencingRepair,
  equipmentMaintenance,
  generalLabor,
}

@immutable
class Job {
  final String id;
  final String title;
  final String crop;
  final String location;
  final double areaHectares;
  final List<String>
      requiredEquipment; // can be empty; may include tractor implements
  final DateTime? scheduledDate;
  final JobType type;
  final double distanceKm;
  final String employerName;

  const Job({
    required this.id,
    required this.title,
    required this.crop,
    required this.location,
    required this.areaHectares,
    required this.requiredEquipment,
    required this.scheduledDate,
    required this.type,
    required this.distanceKm,
    required this.employerName,
  });
}

String jobTypeLabel(JobType t) {
  switch (t) {
    case JobType.fruitPicking:
      return 'Fruit picking';
    case JobType.vegetableHarvest:
      return 'Vegetable harvest';
    case JobType.pruning:
      return 'Pruning';
    case JobType.planting:
      return 'Planting';
    case JobType.weeding:
      return 'Weeding';
    case JobType.irrigationSetup:
      return 'Irrigation setup';
    case JobType.pesticideSpray:
      return 'Pesticide spray';
    case JobType.fertilizerApply:
      return 'Fertilizer apply';
    case JobType.soilPreparation:
      return 'Soil preparation';
    case JobType.tractorMowing:
      return 'Tractor mowing';
    case JobType.baling:
      return 'Baling';
    case JobType.seeding:
      return 'Seeding';
    case JobType.transplanting:
      return 'Transplanting';
    case JobType.greenhouseWork:
      return 'Greenhouse';
    case JobType.packingSorting:
      return 'Packing & sorting';
    case JobType.orchardMaintenance:
      return 'Orchard maintenance';
    case JobType.vineyardTrellising:
      return 'Vineyard trellising';
    case JobType.fencingRepair:
      return 'Fencing repair';
    case JobType.equipmentMaintenance:
      return 'Equipment maintenance';
    case JobType.generalLabor:
      return 'General labor';
  }
}
