import 'package:flutter/foundation.dart';

@immutable
class PhotosState {
  final bool isLoading;
  final Uint8List? data;
  final Object? error;

  const PhotosState({
    required this.isLoading,
    required this.data,
    required this.error,
  });

  const PhotosState.empty()
      : isLoading = false,
        data = null,
        error = null;

  @override
  String toString() => {
        'isLoading': isLoading,
        'hasData': data != null,
        'error': error,
      }.toString();
}
