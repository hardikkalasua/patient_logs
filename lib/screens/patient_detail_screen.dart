import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patient_logs/components/avatar_widget.dart';
import 'package:patient_logs/data/models.dart';
import 'package:patient_logs/data/repository.dart';
import 'package:patient_logs/screens/patient_photos_component.dart';

class PatientDetailScreen extends StatefulWidget {
  final Patient patient;

  PatientDetailScreen({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patient.name),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarWidget(
                    radius: 48.0,
                    path: widget.patient.avatar,
                  ),
                  Flexible(
                    child: ListTile(
                      title: Text(widget.patient.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.man,
                                color: Colors.blue,
                              ),
                              Text(widget.patient.age.toString()),
                            ],
                          ),
                          Text(widget.patient.contact.toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PatientPhotosComponent(
              patientId: widget.patient.id,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          File? image;
          final pickedImage =
              await ImagePicker().pickImage(source: ImageSource.gallery);

          if (pickedImage != null) {
            image = File(pickedImage.path);
            final directory = await getApplicationDocumentsDirectory();
            final patientDirectory =
                Directory('${directory.path}/patient_${widget.patient.id}');
            if (!await patientDirectory.exists()) {
              await patientDirectory.create();
            }
            final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
            final filePath = '${patientDirectory.path}/$fileName';
            final file = File(filePath);
            await file.writeAsBytes(await image.readAsBytes());
            Repository.addCaseImage(CaseImage(
              id: 0,
              title: 'Placeholder Title',
              uri: file.path,
              description: '',
              notes: '',
              patientId: widget.patient.id,
              createdAt: DateTime.now(),
            ));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
