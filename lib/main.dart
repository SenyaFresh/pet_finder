import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_finder/presentation/pets_finder_app.dart';
import 'firebase_options.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  init.initMapkit(
      apiKey: '3aed1996-8860-4107-baff-12010b9464f2'
  );
  runApp(const PetsFinderApp());
}