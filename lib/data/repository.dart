import 'package:patient_logs/data/sql_helper.dart';

import 'models.dart';

class Repository {
  static Future<List<Patient>> getPatients() {
    return SQLHelper.getPatients();
  }

  static Future<int> addPatient(Patient patient) {
    return SQLHelper.createPatient(patient);
  }

  static Future<int> updatePatient(Patient patient) {
    return SQLHelper.updatePatient(patient);
  }

  static Future<void> deletePatient(int patientId) {
    return SQLHelper.deletePatient(patientId);
  }

  static Future<List<CaseImage>> getCaseImages(int patientId) {
    return SQLHelper.getCaseImages(patientId);
  }

  static Future<int> addCaseImage(CaseImage img) {
    return SQLHelper.createCaseImage(img);
  }

  static Future<int> updateCaseImage(CaseImage caseImage) {
    return SQLHelper.updateCaseImage(caseImage);
  }

  static Future<void> deleteCaseImage(int caseImageId) {
    return SQLHelper.deleteCaseImage(caseImageId);
  }
}
