import '../entities/Pet.dart';

abstract class PetsRepository {
  Stream<List<Pet>> getAllPets();

  Stream<List<Pet>> getPetsByCity(String city);

  Future<void> addPet(Pet pet);
}
