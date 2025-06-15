import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_maps_mapkit/image.dart' as image;
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:yandex_maps_mapkit/mapkit_factory.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart';

import '../../domain/entities/Pet.dart';
import '../blocs/pets_bloc.dart';
import '../blocs/pets_state.dart';

class MapScreen extends StatelessWidget {
  final Pet? initialPet;

  const MapScreen({super.key, this.initialPet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Карта питомца')),
      body: BlocBuilder<PetsBloc, PetsState>(
        builder: (context, state) {
          final imageProvider = image.ImageProvider.fromImageProvider(
            const AssetImage("assets/ic_pin.png"),
          );
          return YandexMap(
            onMapCreated: (mapWindow) async {
              dynamic latitude = initialPet!.location.latitude;
              dynamic longitude = initialPet!.location.longitude;
              mapWindow.map.mapObjects.addPlacemark()
                ..geometry = Point(latitude: latitude, longitude: longitude)
                ..setIcon(imageProvider);

              mapWindow.map.move(
                CameraPosition(
                  Point(latitude: latitude, longitude: longitude),
                  zoom: 10,
                  azimuth: 0,
                  tilt: 0,
                ),
              );
              mapkit.onStart();
            },
          );
        },
      ),
    );
  }
}
