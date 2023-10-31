import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patient_logs/components/avatar_widget.dart';
import 'package:patient_logs/data/models.dart';
import 'package:patient_logs/data/repository.dart';
import 'package:patient_logs/screens/patient_photos_component.dart';

class PatientDetailScreen2 extends StatefulWidget {
  final Patient patient;

  PatientDetailScreen2({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientDetailScreen2> createState() => _PatientDetailScreen2State();
}

class _PatientDetailScreen2State extends State<PatientDetailScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: AvatarWidget(
            radius: 48.0,
            path: widget.patient.avatar,
          ),
          title: Text(widget.patient.name),
          subtitle: Text(widget.patient.contact),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.photo_album)),
            Tab(icon: Icon(Icons.notes)),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Colors.blue,
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('SliverAppBar'),
              background: FlutterLogo(),
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: "Tab1"),
                Tab(text: "Tab2"),
                Tab(text: "Tab3"),
                Tab(text: "Tab4"),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              },
              childCount: 20,
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
