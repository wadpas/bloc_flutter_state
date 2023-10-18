import 'package:flutter/foundation.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class UploadImage implements AppEvent {
  final String filePath;

  const UploadImage({
    required this.filePath,
  });
}

@immutable
class DeleteAccount implements AppEvent {
  const DeleteAccount();
}

@immutable
class LogOut implements AppEvent {
  const LogOut();
}

@immutable
class AppInitialize implements AppEvent {
  const AppInitialize();
}

@immutable
class LogIn implements AppEvent {
  final String email;
  final String password;

  const LogIn({
    required this.email,
    required this.password,
  });
}

@immutable
class GoToRegistration implements AppEvent {
  const GoToRegistration();
}

@immutable
class GoToLogin implements AppEvent {
  const GoToLogin();
}

@immutable
class Register implements AppEvent {
  final String email;
  final String password;

  const Register({
    required this.email,
    required this.password,
  });
}
