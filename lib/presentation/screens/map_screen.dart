import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/Pet.dart';
import '../blocs/pets_bloc.dart';
import '../blocs/pets_event.dart';
import '../blocs/pets_state.dart';

class MapScreen extends StatelessWidget {
  final Pet? initialPet;

  const MapScreen({super.key, this.initialPet});

  @override
  Widget build(BuildContext context) {
    if (initialPet != null) {
      context.read<PetsBloc>().add(LoadPetsEvent(city: initialPet!.city));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Карта питомца')),
      body: BlocBuilder<PetsBloc, PetsState>(
        builder: (context, state) {
          if (state is PetsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PetsLoaded) {
            final markers = state.pets.map(
              (pet) => Marker(
                markerId: MarkerId(pet.id),
                position: LatLng(pet.location.latitude, pet.location.longitude),
                infoWindow: InfoWindow(title: pet.name),
                onTap:
                    () => context.read<PetsBloc>().add(
                      MarkSeenEvent(pet.id, pet.location),
                    ),
              ),
            );
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: markers.first.position,
                zoom: 12,
              ),
              markers: Set<Marker>.of(markers),
            );
          }
          return const Center(child: Text('Нет данных'));
        },
      ),
    );
  }
}
