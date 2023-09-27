import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
        ),
        body: Column(
          children: [
            Text('NotesPage'),
          ],
        ));
  }
}
