import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/utils/constants.dart';
import '../models/pet_model.dart';

abstract class PetsRemoteDataSource {
  Stream<List<PetModel>> streamAllPets();

  Stream<List<PetModel>> streamPetsByCity(String city);

  Future<void> addPet(PetModel pet);

  Future<void> markSeen(String petId, GeoPoint location);
}

class PetsRemoteDataSourceImpl implements PetsRemoteDataSource {
  final FirebaseFirestore _firestore;

  PetsRemoteDataSourceImpl(this._firestore);

  @override
  Stream<List<PetModel>> streamAllPets() {
    return _firestore
        .collection(Constants.petsCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((d) => PetModel.fromJson(d.id, d.data())).toList(),
        );
  }

  @override
  Stream<List<PetModel>> streamPetsByCity(String city) {
    return _firestore
        .collection(Constants.petsCollection)
        .where('city', isEqualTo: city)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((d) => PetModel.fromJson(d.id, d.data())).toList(),
        );
  }

  @override
  Future<void> addPet(PetModel pet) async {
    await _firestore.collection(Constants.petsCollection).add(pet.toJson());
  }

  @override
  Future<void> markSeen(String petId, GeoPoint location) async {
    await _firestore
        .collection(Constants.petsCollection)
        .doc(petId)
        .collection(Constants.sightingsSubcollection)
        .add({'location': location, 'timestamp': Timestamp.now()});
  }
}
