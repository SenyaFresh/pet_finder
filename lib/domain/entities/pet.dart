import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String id;
  final String name;
  final Uint8List photoData;
  final GeoPoint location;
  final String city;
  final DateTime timestamp;

  Pet({
    required this.id,
    required this.name,
    required this.photoData,
    required this.location,
    required this.city,
    required this.timestamp,
  });
}
