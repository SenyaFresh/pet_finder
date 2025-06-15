import 'package:bloc/bloc.dart';
import 'package:pet_finder/presentation/blocs/pets_event.dart';
import 'package:pet_finder/presentation/blocs/pets_state.dart';

import '../../domain/entities/Pet.dart';
import '../../domain/usecases/add_pet.dart';
import '../../domain/usecases/get_pets.dart';

class PetsBloc extends Bloc<PetsEvent, PetsState> {
  final GetPets _getLost;
  final AddPet _add;

  PetsBloc(this._getLost, this._add) : super(PetsInitial()) {
    on<LoadPetsEvent>((e, emit) async {
      emit(PetsLoading());
      await emit.forEach<List<Pet>>(
        _getLost(city: e.city),
        onData: (list) => PetsLoaded(list),
        onError: (_, __) => PetsError('Ошибка при загрузке'),
      );
    });
    on<AddPetEvent>((e, emit) async {
      await _add(e.pet);
    });
  }
}
