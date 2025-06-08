import '../repositories/pets_repository.dart';

class MarkPetSeen {
  final PetsRepository repository;

  MarkPetSeen(this.repository);

  Future<void> call(String petId, dynamic location) async {
    await repository.markSeen(petId, location);
  }
}
