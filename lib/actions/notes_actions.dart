import 'package:flutter/foundation.dart';

@immutable
abstract class NotesAction {
  const NotesAction();
}

@immutable
class LoginAction implements NotesAction {
  final String email;
  final String password;

  const LoginAction({
    required this.email,
    required this.password,
  });
}

@immutable
class LoadNotesAction implements NotesAction {
  const LoadNotesAction();
}
