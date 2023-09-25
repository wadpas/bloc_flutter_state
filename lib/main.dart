import 'package:bloc_flutter_state/pages/cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redux Flutter',
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
        title: const Text('Redux Flutter'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/item-filter');
              },
              child: const Text('Item Filter Page'),
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
