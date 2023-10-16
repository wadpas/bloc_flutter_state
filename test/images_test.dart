import 'dart:typed_data';

import 'package:bloc_flutter_state/actions/images_events.dart';
import 'package:bloc_flutter_state/bloc/images_bloc.dart';
import 'package:bloc_flutter_state/states/images_state.dart';
import 'package:bloc_test/bloc_test.dart';

extension ToList on String {
  Uint8List toUint8List() => Uint8List.fromList(codeUnits);
}

final text1Data = 'Foo'.toUint8List();
final text2Data = 'Bar'.toUint8List();

enum Errors { dummy }

void main() {
  blocTest<ImagesBloc, ImagesState>(
    'NotesState is empty',
    build: () => ImagesBloc(
      urls: [],
    ),
    verify: (imagesState) => (
      imagesState.state,
      const ImagesState.empty(),
    ),
  );
  blocTest<ImagesBloc, ImagesState>(
    'NotesState success',
    build: () => ImagesBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text1Data),
    ),
    act: (imagesBloc) => imagesBloc.add(
      const LoadNextUrlEvent(),
    ),
    expect: () => [
      const ImagesState(
        isLoading: true,
        data: null,
        error: null,
      ),
      ImagesState(
        isLoading: false,
        data: text1Data,
        error: null,
      ),
    ],
  );

  blocTest<ImagesBloc, ImagesState>(
    'NotesState has error',
    build: () => ImagesBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.error(Errors.dummy),
    ),
    act: (imagesBloc) => imagesBloc.add(
      const LoadNextUrlEvent(),
    ),
    expect: () => [
      const ImagesState(
        isLoading: true,
        data: null,
        error: null,
      ),
      const ImagesState(
        isLoading: false,
        data: null,
        error: Errors.dummy,
      ),
    ],
  );

  blocTest<ImagesBloc, ImagesState>(
    'NotesState multi success',
    build: () => ImagesBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text1Data),
    ),
    act: (imagesBloc) {
      imagesBloc.add(
        const LoadNextUrlEvent(),
      );
      imagesBloc.add(
        const LoadNextUrlEvent(),
      );
    },
    expect: () => [
      const ImagesState(
        isLoading: true,
        data: null,
        error: null,
      ),
      ImagesState(
        isLoading: false,
        data: text1Data,
        error: null,
      ),
      const ImagesState(
        isLoading: true,
        data: null,
        error: null,
      ),
      ImagesState(
        isLoading: false,
        data: text1Data,
        error: null,
      ),
    ],
  );
}
