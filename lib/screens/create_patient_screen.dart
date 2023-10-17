import 'package:flutter/material.dart';
import 'package:patient_logs/data/models.dart';
import 'package:patient_logs/data/repository.dart';

class CreatePatientScreen extends StatefulWidget {
  const CreatePatientScreen({super.key});

  @override
  State<CreatePatientScreen> createState() => _CreatePatientScreenState();
}

class _CreatePatientScreenState extends State<CreatePatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sexController = TextEditingController();
  final _avatarController = TextEditingController();
  final _ageController = TextEditingController();
  final _contactController = TextEditingController();
  final _complaintController = TextEditingController();
  final _notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Patient'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _avatarController,
                  decoration: const InputDecoration(labelText: 'Avatar'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an avatar';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sexController,
                  decoration: const InputDecoration(labelText: 'Sex'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a sex';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an age';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(labelText: 'Contact'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact number';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid phone';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _complaintController,
                  decoration: const InputDecoration(labelText: 'Complaint'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the complaint';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await Repository.addPatient(Patient(
                            id: 0,
                            name: _nameController.text,
                            age: int.parse(_ageController.text),
                            sex: _sexController.text,
                            avatar: _avatarController.text,
                            contact: _contactController.text,
                            complaint: _complaintController.text,
                            notes: _notesController.text,
                            createdAt: DateTime.now()));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
