import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_finder/presentation/blocs/pets_bloc.dart';
import 'package:pet_finder/presentation/blocs/pets_event.dart';
import 'package:pet_finder/presentation/screens/list_screen.dart';

import '../data/repositories/pets_repository_impl.dart';
import '../data/sources/pets_source.dart';
import '../domain/usecases/add_pet.dart';
import '../domain/usecases/get_pets.dart';

class PetsFinderApp extends StatelessWidget {
  const PetsFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    final remote = PetsRemoteDataSourceImpl(FirebaseFirestore.instance);
    final repo = PetsRepositoryImpl(remote);

    return BlocProvider<PetsBloc>(
      create: (_) => PetsBloc(GetPets(repo), AddPet(repo))..add(LoadPetsEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pet Finder',
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFF4A9D8F),
            onPrimary: Colors.white,
            secondary: Color(0xFF5F62C0),
            onSecondary: Colors.white,
            background: Color(0xFFFAFAFA),
            onBackground: Colors.black87,
            surface: Colors.white,
            onSurface: Colors.black87,
            error: Color(0xFFE76F51),
            onError: Colors.white,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF4A9D8F),
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF4A9D8F)),
            ),
            labelStyle: TextStyle(color: Color(0xFF4A9D8F)),
            prefixIconColor: Color(0xFF4A9D8F),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5F62C0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size.fromHeight(48),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF4A9D8F),
            foregroundColor: Colors.white,
          ),
          cardTheme: CardTheme(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        home: const ListScreen(),
      ),
    );
  }
}
