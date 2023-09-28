import 'package:bloc_flutter_state/models/notes.dart';
import 'package:flutter/foundation.dart';

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
}
