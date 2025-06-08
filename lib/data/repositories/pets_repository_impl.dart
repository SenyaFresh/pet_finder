import '../../domain/entities/Pet.dart';
import '../../domain/repositories/pets_repository.dart';
import '../models/pet_model.dart';
import '../sources/pets_source.dart';

class PetsRepositoryImpl implements PetsRepository {
  final PetsRemoteDataSource remote;

  PetsRepositoryImpl(this.remote);

  @override
  Stream<List<Pet>> getAllPets() => remote.streamAllPets();

  @override
  Stream<List<Pet>> getPetsByCity(String city) => remote.streamPetsByCity(city);

  @override
  Future<void> addPet(Pet pet) async => remote.addPet(
    PetModel(
      id: pet.id,
      name: pet.name,
      photoUrl: pet.photoUrl,
      location: pet.location,
      city: pet.city,
      timestamp: pet.timestamp,
    ),
  );

  @override
  Future<void> markSeen(String petId, dynamic location) async =>
      remote.markSeen(petId, location);
}
