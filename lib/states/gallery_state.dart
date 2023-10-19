import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:bloc_flutter_state/models/auth_errors.dart';

@immutable
abstract class GalleryState {
  final bool isLoading;
  final AuthError? authError;

  const GalleryState({
    required this.isLoading,
    this.authError,
  });
}

@immutable
class GalleryStateLoggedIn extends GalleryState {
  final User user;
  final Iterable<Reference> images;

  const GalleryStateLoggedIn({
    required super.isLoading,
    required this.user,
    required this.images,
    super.authError,
  });

  @override
  bool operator ==(other) {
    final otherClass = other;
    if (otherClass is GalleryStateLoggedIn) {
      return isLoading == otherClass.isLoading &&
          user.uid == otherClass.user.uid &&
          images.length == otherClass.images.length;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(user.uid, images);

  @override
  String toString() => 'GalleryStateLoggedIn, images.length = ${images.length}';
}

@immutable
class GalleryStateLoggedOut extends GalleryState {
  const GalleryStateLoggedOut({
    required super.isLoading,
    super.authError,
  });

  @override
  String toString() =>
      'GalleryStateLoggedOut, isLoading = $isLoading, authError = $authError';
}

@immutable
class GalleryStateRegistration extends GalleryState {
  const GalleryStateRegistration({
    required super.isLoading,
    super.authError,
  });
}

extension GetUser on GalleryState {
  User? get user {
    final cls = this;
    if (cls is GalleryStateLoggedIn) {
      return cls.user;
    } else {
      return null;
    }
  }
}

extension GetImages on GalleryState {
  Iterable<Reference>? get images {
    final cls = this;
    if (cls is GalleryStateLoggedIn) {
      return cls.images;
    } else {
      return null;
    }
  }
}
