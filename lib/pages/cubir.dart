import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

const names = ['Foo', 'Bar', 'Baz'];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        math.Random().nextInt(length),
      );
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() => emit(
        names.getRandomElement(),
      );
}

class CubitPage extends StatelessWidget {
  const CubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit Page'),
      ),
      body: Container(
        child: Text('Cubit'),
      ),
    );
  }
}
