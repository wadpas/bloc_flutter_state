import 'package:bloc_flutter_state/pages/gallery_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:bloc_flutter_state/bloc/persons_bloc.dart';
import 'package:bloc_flutter_state/firebase_options.dart';
import 'package:bloc_flutter_state/pages/images_page.dart';
import 'package:bloc_flutter_state/pages/notes_page.dart';
import 'package:bloc_flutter_state/pages/persons_page.dart';
import 'package:bloc_flutter_state/pages/random_name_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.nunitoTextTheme().copyWith(
          labelLarge: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: const HomePage(),
      routes: {
        '/gallery': (context) => const GalleryPage(),
        '/images': (context) => const ImagesPage(),
        '/notes': (context) => const NotesPage(),
        '/persons': (context) => const PersonsPage(),
        '/random_name': (context) => const RandomNamePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Flutter'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/gallery');
              },
              child: const Text('Gallery'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/images');
              },
              child: const Text('Images'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/notes');
              },
              child: const Text('Notes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/persons');
              },
              child: const Text('Persons'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/random_name');
              },
              child: const Text('Random Name'),
            ),
          ],
        ),
      ),
    );
  }
}
