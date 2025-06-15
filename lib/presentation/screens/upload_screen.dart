import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/Pet.dart';
import '../blocs/pets_bloc.dart';
import '../blocs/pets_event.dart';
import 'list_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  Uint8List? _photoData;
  String? _name, _city;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pick = await _picker.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      final bytes = await pick.readAsBytes();
      setState(() => _photoData = bytes);
    }
  }

  Future<void> _submit() async {
    if (_photoData == null || _name == null || _city == null) return;
    final pos = await Geolocator.getCurrentPosition();
    final pet = Pet(
      id: '',
      name: _name!,
      photoData: _photoData!,
      location: GeoPoint(pos.latitude, pos.longitude),
      city: _city!,
      timestamp: DateTime.now(),
    );
    context.read<PetsBloc>().add(AddPetEvent(pet));
    context.read<PetsBloc>().add(LoadPetsEvent(city: _city));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить питомца')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_photoData != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  _photoData!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Выбрать фото'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Кличка'),
              onChanged: (v) => _name = v,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Город'),
              onChanged: (v) => _city = v,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Опубликовать'),
            ),
          ],
        ),
      ),
    );
  }
}
