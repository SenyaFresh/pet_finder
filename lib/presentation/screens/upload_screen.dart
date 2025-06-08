import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  File? _image;
  String? _name, _city;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pick = await _picker.pickImage(source: ImageSource.gallery);
    if (pick != null) setState(() => _image = File(pick.path));
  }

  Future<void> _submit() async {
    if (_image == null || _name == null || _city == null) return;
    final storageRef = FirebaseStorage.instance.ref(
      'pets/${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    final task = await storageRef.putFile(_image!);
    final url = await task.ref.getDownloadURL();
    final pos = await Geolocator.getCurrentPosition();
    final pet = Pet(
      id: '',
      name: _name!,
      photoUrl: url,
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
          children: [
            if (_image != null) Image.file(_image!, height: 200),
            ElevatedButton(onPressed: _pickImage, child: const Text('Фото')),
            TextField(
              decoration: const InputDecoration(labelText: 'Кличка'),
              onChanged: (v) => _name = v,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Город'),
              onChanged: (v) => _city = v,
            ),
            const SizedBox(height: 20),
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
