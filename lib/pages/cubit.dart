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

class CubitPage extends StatefulWidget {
  const CubitPage({super.key});

  @override
  State<CubitPage> createState() => _CubitPageState();
}

class _CubitPageState extends State<CubitPage> {
  late final NamesCubit cubit;

  @override
  void initState() {
    cubit = NamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit Page'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: StreamBuilder<String?>(
          stream: cubit.stream,
          builder: (context, snapshot) {
            final button = ElevatedButton(
              onPressed: () {
                cubit.pickRandomName();
              },
              child: const Text('Random Name'),
            );
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return button;
              case ConnectionState.waiting:
                return button;
              case ConnectionState.active:
                return Column(
                  children: [
                    Text(snapshot.data ?? ''),
                    button,
                  ],
                );
              case ConnectionState.done:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
