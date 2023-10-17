class Patient {
  final int id;
  final String name;
  final int age;
  final String sex;
  final String avatar;
  final String complaint;
  final String contact;
  final String notes;
  final DateTime createdAt;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.sex,
    required this.avatar,
    required this.contact,
    required this.complaint,
    required this.notes,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'sex': sex,
      'avatar': avatar,
      'contact': contact,
      'complaint': complaint,
      'notes': notes
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      sex: map['sex'],
      avatar: map['avatar'],
      contact: map['contact'],
      complaint: map['complaint'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}

class CaseImage {
  final int id;
  final String uri;
  final String title;
  final String description;
  final String notes;
  final int patientId;
  final DateTime createdAt;

  CaseImage({
    required this.id,
    required this.title,
    required this.uri,
    required this.description,
    required this.notes,
    required this.patientId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uri': uri,
      'title': title,
      'description': description,
      'notes': notes,
      'patient_id': patientId,
    };
  }

  factory CaseImage.fromMap(Map<String, dynamic> map) {
    return CaseImage(
      id: map['id'],
      uri: map['uri'],
      title: map['title'],
      description: map['description'],
      notes: map['notes'],
      patientId: map['patient_id'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
