import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_finder/presentation/blocs/pets_bloc.dart';
import 'package:pet_finder/presentation/blocs/pets_event.dart';

import '../data/repositories/pets_repository_impl.dart';
import '../data/sources/pets_source.dart';
import '../domain/usecases/add_pet.dart';
import '../domain/usecases/get_pets.dart';
import '../domain/usecases/mark_pet_seen.dart';

class PetsFinderApp extends StatelessWidget {
  const PetsFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    final remote = PetsRemoteDataSourceImpl(FirebaseFirestore.instance);
    final repo = PetsRepositoryImpl(remote);
    return BlocProvider(
      create:
          (_) =>
              PetsBloc(GetPets(repo), AddPet(repo), MarkPetSeen(repo))
                ..add(LoadPetsEvent()),
      child: MaterialApp(
        title: 'Потерянные питомцы'
      ),
    );
  }
}
