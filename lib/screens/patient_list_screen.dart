import 'dart:io';

import 'package:flutter/material.dart';
import 'package:patient_logs/components/avatar_widget.dart';
import 'package:patient_logs/data/repository.dart';
import 'package:patient_logs/screens/patient_detail_screen.dart';
import 'dart:async';
import 'package:patient_logs/data/models.dart';

import 'create_patient_screen.dart';

class PatientListScreen extends StatefulWidget {
  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  late Future<List<Patient>> futurePatients;

  @override
  void initState() {
    super.initState();
    futurePatients = Repository.getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient List'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            futurePatients = Repository.getPatients();
          });
        },
        child: Center(
          child: FutureBuilder<List<Patient>>(
            future: futurePatients,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: AvatarWidget(
                          radius: 28,
                          avatar: File(snapshot.data![index].avatar),
                        ),
                        title: Text(snapshot.data![index].name),
                        subtitle: Text(snapshot.data![index].complaint),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientDetailScreen(
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
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
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
