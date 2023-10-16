import 'package:bloc_flutter_state/actions/images_events.dart';
import 'package:bloc_flutter_state/states/images_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

typedef UrlRandomPicker = String Function(Iterable<String> imagesUrls);
typedef UrlLoader = Future<Uint8List> Function(String url);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        math.Random().nextInt(length),
      );
}

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  String _pickRandomUrl(Iterable<String> imagesUrls) =>
      imagesUrls.getRandomElement();

  Future<Uint8List> _loadUrl(String url) => NetworkAssetBundle(Uri.parse(url))
      .load(url)
      .then((byteData) => byteData.buffer.asUint8List());

  ImagesBloc({
    required Iterable<String> urls,
    Duration? waitBeforeLoading,
    UrlRandomPicker? urlPicker,
    UrlLoader? urlLoader,
  }) : super(const ImagesState.empty()) {
    on<LoadNextUrlEvent>((event, emit) async {
      emit(
        const ImagesState(
          isLoading: true,
          data: null,
          error: null,
        ),
      );
      final url = (urlPicker ?? _pickRandomUrl)(urls);
      try {
        if (waitBeforeLoading != null) {
          await Future.delayed(waitBeforeLoading);
        }
        final data = await (urlLoader ?? _loadUrl)(url);
        emit(
          ImagesState(
            isLoading: false,
            data: data,
            error: null,
          ),
        );
      } catch (error) {
        emit(
          ImagesState(
            isLoading: false,
            data: null,
            error: error,
          ),
        );
      }
    });
  }
}

class TopBloc extends ImagesBloc {
  TopBloc({
    required super.waitBeforeLoading,
    required super.urls,
  });
}

class BottomBloc extends ImagesBloc {
  BottomBloc({
    required super.waitBeforeLoading,
    required super.urls,
  });
}
