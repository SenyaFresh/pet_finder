import '../../domain/entities/Pet.dart';

abstract class PetsState {}

class PetsInitial extends PetsState {}

class PetsLoading extends PetsState {}

class PetsLoaded extends PetsState {
  final List<Pet> pets;

  PetsLoaded(this.pets);
}

class PetsError extends PetsState {
  final String message;

  PetsError(this.message);
}
