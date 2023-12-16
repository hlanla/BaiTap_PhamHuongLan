import 'dart:math';

import 'package:hive/hive.dart';
import 'package:jogging_app/constant/hive_db.dart';
import 'package:jogging_app/data/local/observation.dart';

class ObservationRepository {
  static final ObservationRepository _singleton =
      ObservationRepository._internal();

  factory ObservationRepository() {
    return _singleton;
  }

  ObservationRepository._internal() {
    _observationBox = Hive.box(HiveBoxName.observation);
  }

  late final Box<Observation> _observationBox;
  Observation? observationDetail;

  Future<List<Observation>> getListJogging() async {
    return _observationBox.values.toList();
  }

  Future<void> getObservationById(int id) async {
    observationDetail =
        _observationBox.values.where((element) => element.id == id).first;
  }

  Future<void> addOrEditObservation(Observation model) async {
    final listData = _observationBox.values.map((e) => e.id).toList();

    if (listData.isEmpty) {
      await _observationBox.put(
        0,
        model.copyWith(id: 0),
      );
    } else {
      if (listData.contains(model.id)) {
        await _observationBox.put(
          model.id,
          model,
        );
      } else {
        final key = listData.reduce(max);
        await _observationBox.put(
          key + 1,
          model.copyWith(id: key + 1),
        );
      }
    }
  }

  Future<void> removeObservation(int id) async {
    await _observationBox.delete(id);
  }

  Future<void> deleteAllObservationOfJogging(int joggingId) async {
    List<int> listObservation = _observationBox.values
        .where((element) => element.joggingId == joggingId)
        .toList()
        .map((e) => e.id)
        .toList();

    if (listObservation.isNotEmpty) {
      await _observationBox.deleteAll(listObservation);
    }
  }
}
