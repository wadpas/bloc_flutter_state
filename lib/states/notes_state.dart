import 'package:bloc_flutter_state/models/notes.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

@immutable
class NotesState {
  final bool isLoading;
  final LoginErrors? loginError;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchedNotes;

  const NotesState.empty()
      : isLoading = false,
        loginError = null,
        loginHandle = null,
        fetchedNotes = null;

  const NotesState({
    required this.isLoading,
    required this.loginError,
    required this.loginHandle,
    required this.fetchedNotes,
  });

  @override
  String toString() => {
        'isLoading': isLoading,
        'loginError': loginError,
        'loginHandle': loginHandle,
        'fetchedNotes': fetchedNotes,
      }.toString();

  @override
  bool operator ==(covariant NotesState other) =>
      isLoading == other.isLoading &&
      loginError == other.loginError &&
      loginHandle == other.loginHandle &&
      (fetchedNotes?.isEqualTo(other.fetchedNotes) ??
          fetchedNotes == null && other.fetchedNotes == null);

  @override
  int get hashCode => Object.hash(
        isLoading,
        loginError,
        loginHandle,
        fetchedNotes,
      );
}

extension UnorderedEquality on Object {
  bool isEqualTo(other) =>
      const DeepCollectionEquality.unordered().equals(this, other);
}
