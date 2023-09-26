import 'package:bloc_flutter_state/pages/bloc.dart';
import 'package:bloc_flutter_state/pages/cubit.dart';
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
          '/cubit-page': (context) => const CubitPage(),
          '/bloc-page': (context) => const BlocPage(),
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
                Navigator.of(context).pushNamed('/bloc-page');
              },
              child: const Text('Bloc Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cubit-page');
              },
              child: const Text('Cubit Page'),
            ),
          ],
        ),
      ),
    );
  }
}
