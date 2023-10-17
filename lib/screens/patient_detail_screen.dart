import 'package:flutter/material.dart';
import 'package:patient_logs/data/models.dart';
import 'package:patient_logs/screens/patient_photos_component.dart';

class PatientDetailScreen extends StatelessWidget {
  final Patient patient;

  const PatientDetailScreen({Key? key, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patient.name),
      ),
      body: Column(
        children: [
          Text('Name : ${patient.name}'),
          Text('Contact : ${patient.contact}'),
          Text('Created At : ${patient.createdAt}'),
          Text('Complaint : ${patient.complaint}'),
          Text('Notes : ${patient.notes}'),
          const Expanded(
            child: PatientPhotosComponent(),
          ),
        ],
      ),
    );
  }
}
