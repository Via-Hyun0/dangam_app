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
  harvesting,
  fertilizing,
  pestControl,
  fencing,
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
      return '과일 수확';
    case JobType.vegetableHarvest:
      return '채소 수확';
    case JobType.pruning:
      return '가지치기';
    case JobType.planting:
      return '심기';
    case JobType.weeding:
      return '제초';
    case JobType.irrigationSetup:
      return '관수 설치';
    case JobType.pesticideSpray:
      return '농약 살포';
    case JobType.fertilizerApply:
      return '비료 시용';
    case JobType.soilPreparation:
      return '토양 준비';
    case JobType.tractorMowing:
      return '트랙터 제초';
    case JobType.baling:
      return '건초 포장';
    case JobType.seeding:
      return '파종';
    case JobType.transplanting:
      return '이식';
    case JobType.greenhouseWork:
      return '온실 작업';
    case JobType.packingSorting:
      return '포장 및 선별';
    case JobType.orchardMaintenance:
      return '과수원 관리';
    case JobType.vineyardTrellising:
      return '포도밭 지주 설치';
    case JobType.fencingRepair:
      return '울타리 수리';
    case JobType.equipmentMaintenance:
      return '장비 관리';
    case JobType.generalLabor:
      return '일반 작업';
    case JobType.harvesting:
      return '수확';
    case JobType.fertilizing:
      return '비료 주기';
    case JobType.pestControl:
      return '해충 방제';
    case JobType.fencing:
      return '울타리 설치';
  }
}
