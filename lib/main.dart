import 'package:bloc_flutter_state/bloc/persons_bloc.dart';
import 'package:bloc_flutter_state/pages/persons.dart';
import 'package:bloc_flutter_state/pages/random_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonsBloc(),
      child: MaterialApp(
        title: 'Bloc Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.mooliTextTheme().copyWith(
            labelLarge: GoogleFonts.mooli(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            bodyMedium: GoogleFonts.mooli(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        home: const HomePage(),
        routes: {
          '/persons': (context) => const PersonsPage(),
          '/random_name': (context) => const RandomNamePage(),
        },
      ),
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
