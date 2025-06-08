import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Город'),
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
                } else if (state is PetsLoaded) {
                  return ListView.builder(
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
                } else if (state is PetsError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
