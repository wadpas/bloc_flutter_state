import 'dart:io';
import 'package:bloc_flutter_state/actions/gallery_events.dart';
import 'package:bloc_flutter_state/models/auth_errors.dart';
import 'package:bloc_flutter_state/states/gallery_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc()
      : super(
          const GalleryStateLoggedOut(
            isLoading: false,
          ),
        ) {
    on<GoToRegistration>(
      (event, emit) {
        const GalleryStateRegistration(
          isLoading: false,
        );
      },
    );

    on<LogIn>(
      (event, emit) async {
        emit(
          const GalleryStateLoggedOut(
            isLoading: true,
          ),
        );
        try {
          final email = event.email;
          final password = event.password;
          final credentials =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          final user = credentials.user!;
          final images = await _getImages(user.uid);
          emit(
            GalleryStateLoggedIn(isLoading: false, user: user, images: images),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            GalleryStateLoggedOut(
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        }
      },
    );

    on<GoToLogin>(
      (event, emit) {
        emit(
          const GalleryStateLoggedOut(
            isLoading: false,
          ),
        );
      },
    );

    on<Register>(
      (event, emit) async {
        emit(
          const GalleryStateRegistration(
            isLoading: false,
          ),
        );
        final email = event.email;
        final password = event.password;
        try {
          final credentials =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          emit(
            GalleryStateLoggedIn(
              isLoading: false,
              user: credentials.user!,
              images: const [],
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            GalleryStateRegistration(
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        }
      },
    );

    on<Initialize>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(
            const GalleryStateLoggedOut(
              isLoading: false,
            ),
          );
        } else {
          final images = await _getImages(user.uid);
          emit(
            GalleryStateLoggedIn(
              isLoading: false,
              user: user,
              images: images,
            ),
          );
        }
      },
    );

    on<LogOut>(
      (event, emit) async {
        emit(
          const GalleryStateLoggedOut(
            isLoading: true,
          ),
        );
        await FirebaseAuth.instance.signOut();
        emit(
          const GalleryStateLoggedOut(
            isLoading: false,
          ),
        );
      },
    );

    on<DeleteAccount>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(
            const GalleryStateLoggedOut(
              isLoading: false,
            ),
          );
          return;
        }
        emit(
          GalleryStateLoggedIn(
            isLoading: true,
            user: user,
            images: state.images ?? [],
          ),
        );
        try {
          final folderFiles =
              await FirebaseStorage.instance.ref(user.uid).listAll();
          for (final item in folderFiles.items) {
            await item.delete().catchError((_) {});
          }
          await FirebaseStorage.instance
              .ref(user.uid)
              .delete()
              .catchError((_) {});
          await user.delete();
          await FirebaseAuth.instance.signOut();
          emit(
            const GalleryStateLoggedOut(
              isLoading: false,
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            GalleryStateLoggedIn(
              isLoading: false,
              user: user,
              images: state.images ?? [],
              authError: AuthError.from(e),
            ),
          );
        } on FirebaseException {
          emit(
            const GalleryStateLoggedOut(
              isLoading: false,
            ),
          );
        }
      },
    );

    on<UploadImage>(
      (event, emit) async {
        final user = state.user;
        if (user == null) {
          emit(
            const GalleryStateLoggedOut(
              isLoading: false,
            ),
          );
          return;
        }
        emit(
          GalleryStateLoggedIn(
            isLoading: true,
            user: user,
            images: state.images ?? [],
          ),
        );

        final file = File(event.filePath);
        await _uploadImage(
          file: file,
          userId: user.uid,
        );

        final images = await _getImages(user.uid);
        emit(
          GalleryStateLoggedIn(
            isLoading: false,
            user: user,
            images: images,
          ),
        );
      },
    );
  }

  Future<bool> _uploadImage({
    required File file,
    required String userId,
  }) =>
      FirebaseStorage.instance
          .ref(userId)
          .child(const Uuid().v4())
          .putFile(file)
          .then((_) => true)
          .catchError((_) => false);

  Future<Iterable<Reference>> _getImages(String userId) =>
      FirebaseStorage.instance
          .ref(userId)
          .list()
          .then((listResult) => listResult.items);
}
