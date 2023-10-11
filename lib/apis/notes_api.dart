import 'package:bloc_flutter_state/models/notes.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  });
}

@immutable
class NotesApi implements NotesApiProtocol {
  const NotesApi._sharedInstance();
  static const NotesApi _shared = NotesApi._sharedInstance();
  factory NotesApi() => _shared;

  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle}) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => loginHandle == const LoginHandle.foobar() ? mockedNotes : null,
    );
  }
}
