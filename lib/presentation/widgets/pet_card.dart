import 'package:flutter/material.dart';

import '../../domain/entities/Pet.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onTap;

  const PetCard({super.key, required this.pet, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Image.network(
          pet.photoUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(pet.name),
        subtitle: Text('${pet.city}, ${pet.timestamp.toLocal()}'),
        onTap: onTap,
      ),
    );
  }
}
