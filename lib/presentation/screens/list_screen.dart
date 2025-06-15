import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_finder/presentation/screens/upload_screen.dart';

import '../blocs/pets_bloc.dart';
import '../blocs/pets_event.dart';
import '../blocs/pets_state.dart';
import '../widgets/pet_card.dart';
import 'map_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список питомцев')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Город',
                prefixIcon: const Icon(Icons.location_city),
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onChanged: (v) {
                _filter = v;
                context.read<PetsBloc>().add(LoadPetsEvent(city: _filter));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<PetsBloc, PetsState>(
              builder: (context, state) {
                if (state is PetsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is PetsLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: state.pets.length,
                    itemBuilder:
                        (c, i) => PetCard(
                          pet: state.pets[i],
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          MapScreen(initialPet: state.pets[i]),
                                ),
                              ),
                        ),
                  );
                }
                if (state is PetsError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UploadScreen()),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
