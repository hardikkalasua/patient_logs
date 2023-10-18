import 'dart:io';

import 'package:flutter/material.dart';
import 'package:patient_logs/data/models.dart';
import 'package:patient_logs/data/repository.dart';

class PatientPhotosComponent extends StatefulWidget {
  final int patientId;
  const PatientPhotosComponent({super.key, required this.patientId});

  @override
  State<PatientPhotosComponent> createState() => _PatientPhotosComponentState();
}

class _PatientPhotosComponentState extends State<PatientPhotosComponent> {
  late Future<List<CaseImage>> images;

  @override
  void initState() {
    super.initState();
    images = Repository.getCaseImages(widget.patientId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CaseImage>>(
      future: images,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.file(
                File(snapshot.data![index].uri),
                fit: BoxFit.cover,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
