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

  @override
  bool operator ==(covariant ImagesState other) =>
      isLoading == other.isLoading &&
      (data ?? []).isEqualTo(other.data ?? []) &&
      error == other.error;

  @override
  int get hashCode => Object.hash(isLoading, data, error);
}

extension Comparison<E> on List<E> {
  bool isEqualTo(List<E> other) {
    if (identical(this, other)) {
      return true;
    }
    if (length != other.length) {
      return false;
    }
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}
