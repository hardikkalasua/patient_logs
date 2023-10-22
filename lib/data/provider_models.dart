import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:patient_logs/data/models.dart';

import 'repository.dart';

class PatientListModel extends ChangeNotifier {
  // internal private list of patients
  List<Patient> _patients = [];

  UnmodifiableListView<Patient> get patients => UnmodifiableListView(_patients);

  int get totalPatients => _patients.length;

  Future<List<Patient>> getPatients() async {
    _patients = await Repository.getPatients();
    notifyListeners();
    return _patients;
  }

  void add(Patient item) {
    _patients.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes an item with the give id from the list.
  void remove(int id) {
    _patients.removeWhere((item) => item.id == id);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
