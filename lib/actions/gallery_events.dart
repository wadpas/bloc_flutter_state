import 'package:flutter/foundation.dart';

@immutable
abstract class GalleryEvent {
  const GalleryEvent();
}

@immutable
class UploadImage implements GalleryEvent {
  final String filePath;

  const UploadImage({
    required this.filePath,
  });
}

@immutable
class DeleteAccount implements GalleryEvent {
  const DeleteAccount();
}

@immutable
class LogOut implements GalleryEvent {
  const LogOut();
}

@immutable
class Initialize implements GalleryEvent {
  const Initialize();
}

@immutable
class LogIn implements GalleryEvent {
  final String email;
  final String password;

  const LogIn({
    required this.email,
    required this.password,
  });
}

@immutable
class GoToRegistration implements GalleryEvent {
  const GoToRegistration();
}

@immutable
class GoToLogin implements GalleryEvent {
  const GoToLogin();
}

@immutable
class Register implements GalleryEvent {
  final String email;
  final String password;

  const Register({
    required this.email,
    required this.password,
  });
}
