import 'dart:math';

import 'package:hive/hive.dart';
import 'package:jogging_app/constant/hive_db.dart';
import 'package:jogging_app/data/local/hiking.dart';

import '../local/observation.dart';

class HikingRepository {
  static final HikingRepository _singleton = HikingRepository._internal();

  factory HikingRepository() {
    return _singleton;
  }

  HikingRepository._internal() {
    _joggingBox = Hive.box(HiveBoxName.hiking);
    _observationBox = Hive.box(HiveBoxName.observation);
    listData = [];
    listObservation = [];
  }

  late final Box<Hiking> _joggingBox;
  late final Box<Observation> _observationBox;

  List<Hiking>? listData;
  List<Observation>? listObservation;

  Hiking? joggingDetail;

  Future<void> getListHiking() async {
    listData = _joggingBox.values.toList();
  }

  Future<void> searchByName(String name) async {
    listData = _joggingBox.values
        .where(
          (element) => element.hikeName.contains(
            name.trim(),
          ),
        )
        .toList();
  }

  Future<void> getListObservation(int joggingId) async {
    listObservation = _observationBox.values
        .where((element) => element.joggingId == joggingId)
        .toList();
  }

  Future<void> getHikingById(int id) async {
    joggingDetail =
        _joggingBox.values.toList().firstWhere((element) => element.id == id);
  }

  Future<void> addEditHiking(Hiking model) async {
    final listData = _joggingBox.values.map((e) => e.id).toList();
    if (listData.isEmpty) {
      await _joggingBox.put(
        0,
        model.copyWith(id: 0),
      );
    } else {
      if (listData.contains(model.id)) {
        await _joggingBox.put(
          model.id,
          model,
        );
      } else {
        final key = listData.reduce(max);
        await _joggingBox.put(
          key + 1,
          model.copyWith(id: key + 1),
        );
      }
    }
  }

  Future<void> removeHiking(int id) async {
    await _joggingBox.delete(id);
    final listKey = _observationBox.values
        .where((element) => element.joggingId == id)
        .map((e) => e.id);
    await _observationBox.deleteAll(listKey);
  }

  Future<void> removeObservation(int id) async {
    await _observationBox.delete(id);
  }

  Future<void> deleteAllHiking() async {
    await _joggingBox.clear();
    await _observationBox.clear();
  }
}
