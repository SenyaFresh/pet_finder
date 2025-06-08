import '../entities/Pet.dart';
import '../repositories/pets_repository.dart';

class GetPets {
  final PetsRepository repository;

  GetPets(this.repository);

  Stream<List<Pet>> call({String? city}) {
    return city == null || city.isEmpty
        ? repository.getAllPets()
        : repository.getPetsByCity(city);
  }
}
