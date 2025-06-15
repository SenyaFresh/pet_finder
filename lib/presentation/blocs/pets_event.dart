import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/Pet.dart';

abstract class PetsEvent {}

class LoadPetsEvent extends PetsEvent {
  final String? city;

  LoadPetsEvent({this.city});
}

class AddPetEvent extends PetsEvent {
  final Pet pet;

  AddPetEvent(this.pet);
}