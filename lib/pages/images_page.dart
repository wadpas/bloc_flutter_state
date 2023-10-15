import 'package:bloc_flutter_state/bloc/images_bloc.dart';
import 'package:bloc_flutter_state/models/images.dart';
import 'package:bloc_flutter_state/widgets/images_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagesPage extends StatelessWidget {
  const ImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TopBloc>(
            create: (_) => TopBloc(
              waitBeforeLoading: const Duration(seconds: 1),
              urls: images,
            ),
          ),
          BlocProvider<BottomBloc>(
            create: (_) => BottomBloc(
              waitBeforeLoading: const Duration(seconds: 1),
              urls: images,
            ),
          ),
        ],
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ImagesView<TopBloc>(),
            ImagesView<BottomBloc>(),
          ],
        ),
      ),
    );
  }
}
