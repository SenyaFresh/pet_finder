import '../entities/Pet.dart';
import '../repositories/pets_repository.dart';

class AddPet {
  final PetsRepository repository;

  AddPet(this.repository);

  Future<void> call(Pet pet) async {
    await repository.addPet(pet);
  }
}
