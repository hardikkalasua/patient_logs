import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient_logs/data/models.dart';
import 'package:patient_logs/data/repository.dart';
import 'package:patient_logs/utils.dart';

import '../components/avatar_widget.dart';

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

  File? _avatar;
  // Declare a variable to store the selected value
  String? _sex;

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar field
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () async {
                      // Pick an image from the gallery
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          // Set the avatar image
                          _avatar = File(image.path);
                        });
                      }
                    },
                    child: AvatarWidget(
                      radius: 64,
                      avatar: _avatar,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _sexController,
                    decoration: const InputDecoration(
                      labelText: 'Sex',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a sex';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _contactController,
                    decoration: const InputDecoration(
                      labelText: 'Contact',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _complaintController,
                    decoration: const InputDecoration(
                      labelText: 'Complaint',
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the complaint';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        // The width will be 100% of the parent widget
                        // The height will be 60
                        minimumSize: const Size.fromHeight(60)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Saving Data')),
                        );

                        if (_avatar != null) {
                          _avatarController.text = await saveImageAndReturnPath(
                            file: _avatar!,
                            dirPath: 'avatars',
                          );
                        }

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
                    child: const Text('SAVE'),
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
