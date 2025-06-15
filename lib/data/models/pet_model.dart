import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/Pet.dart';

class PetModel extends Pet {
  PetModel({
    required super.id,
    required super.name,
    required super.photoData,
    required super.location,
    required super.city,
    required super.timestamp,
  });

  factory PetModel.fromJson(String id, Map<String, dynamic> json) {
    return PetModel(
      id: id,
      name: json['name'],
      photoData: (json['photoData'] as Blob).bytes,
      location: json['location'],
      city: json['city'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'photoData': Blob(photoData),
    'location': location,
    'city': city,
    'timestamp': Timestamp.fromDate(timestamp),
  };
}
