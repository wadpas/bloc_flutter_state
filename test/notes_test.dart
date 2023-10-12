import 'package:bloc_flutter_state/apis/notes_api.dart';
import 'package:bloc_flutter_state/models/notes.dart';
import 'package:flutter/foundation.dart';

const Iterable<Note> mockNotes = [
  Note(title: 'Note 1'),
  Note(title: 'Note 2'),
  Note(title: 'Note 3'),
];

@immutable
class DummyNotesApi implements NotesApiProtocol {
  final LoginHandle acceptedLoginHandle;
  final Iterable<Note>? acceptedNotesLoginHandle;

  const DummyNotesApi({
    required this.acceptedLoginHandle,
    required this.acceptedNotesLoginHandle,
  });

  const DummyNotesApi.empty()
      : acceptedLoginHandle = const LoginHandle.foobar(),
        acceptedNotesLoginHandle = null;

  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) async {
    if (loginHandle == acceptedLoginHandle) {
      return acceptedNotesLoginHandle;
    } else {
      return null;
    }
  }
}
