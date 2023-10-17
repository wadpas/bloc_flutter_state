import 'package:async/async.dart';
import 'package:bloc_flutter_state/actions/images_events.dart';
import 'package:bloc_flutter_state/bloc/images_bloc.dart';
import 'package:bloc_flutter_state/states/images_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension<T> on Stream<T> {
  Stream<T> startWith(T value) => StreamGroup.merge(
        [
          this,
          Stream<T>.value(value),
        ],
      );
}

class ImagesView<T extends ImagesBloc> extends StatelessWidget {
  const ImagesView({super.key});

  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 5),
      (_) => const LoadNextUrlEvent(),
    ).startWith(const LoadNextUrlEvent()).forEach((event) {
      context.read<T>().add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, ImagesState>(
        builder: (context, imagesState) {
          if (imagesState.error != null) {
            return const Center(
              child: Text('Error occurred!'),
            );
          } else if (imagesState.data != null) {
            return Image.memory(
              imagesState.data!,
              fit: BoxFit.fitHeight,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
