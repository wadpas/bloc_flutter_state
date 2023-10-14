import 'package:flutter/foundation.dart';

@immutable
class ImagesState {
  final bool isLoading;
  final Uint8List? data;
  final Object? error;

  const ImagesState({
    required this.isLoading,
    required this.data,
    required this.error,
  });

  const ImagesState.empty()
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
