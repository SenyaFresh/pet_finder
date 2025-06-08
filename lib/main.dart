import 'package:flutter/cupertino.dart';
import 'package:pet_finder/presentation/pets_finder_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PetsFinderApp());
}