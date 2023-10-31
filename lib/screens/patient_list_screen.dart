import 'dart:io';

import 'package:flutter/material.dart';
import 'package:patient_logs/components/avatar_widget.dart';
import 'package:patient_logs/data/provider_models.dart';
import 'package:patient_logs/data/repository.dart';
import 'package:patient_logs/screens/patient_detail_screen.dart';
import 'dart:async';
import 'package:patient_logs/data/models.dart';
import 'package:patient_logs/screens/patient_detail_screen2.dart';
import 'package:provider/provider.dart';

import 'create_patient_screen.dart';

class PatientListScreen extends StatefulWidget {
  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedLog'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton(
            child: const Icon(Icons.sort),
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'All',
                child: Text('Most Recent'),
              ),
              const PopupMenuItem<String>(
                value: 'All',
                child: Text('Oldest First'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Consumer<PatientListModel>(
          builder: (context, patientList, child) {
            return FutureBuilder<List<Patient>>(
                future: patientList.getPatients(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: patientList.patients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: AvatarWidget(
                              radius: 28,
                              path: snapshot.data![index].avatar,
                            ),
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(snapshot.data![index].complaint),
                            trailing: Icon(Icons.arrow_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientDetailScreen2(
                                    patient: snapshot.data![index],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Text(
                        'Looks like nothing\' here. Click on the + button to create a new Log.');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePatientScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
