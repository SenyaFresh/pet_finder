import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String id;
  final String name;
  final String photoUrl;
  final GeoPoint location;
  final String city;
  final DateTime timestamp;

  Pet({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.location,
    required this.city,
    required this.timestamp,
  });
}
