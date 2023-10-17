import 'package:flutter/material.dart';
import 'package:patient_logs/data/models.dart';
import 'package:patient_logs/data/repository.dart';

class PatientPhotosComponent extends StatefulWidget {
  const PatientPhotosComponent({super.key});

  @override
  State<PatientPhotosComponent> createState() => _PatientPhotosComponentState();
}

class _PatientPhotosComponentState extends State<PatientPhotosComponent> {
  late Future<List<CaseImage>> images;

  @override
  void initState() {
    super.initState();
    images = Repository.getCaseImages(1);
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
              return Image.network(snapshot.data![index].uri);
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
