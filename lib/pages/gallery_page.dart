import 'package:bloc_flutter_state/dialogs/loading_screen.dart';
import 'package:bloc_flutter_state/dialogs/show_auth_error.dart';
import 'package:bloc_flutter_state/states/gallery_state.dart';
import 'package:bloc_flutter_state/widgets/gallery_view.dart';
import 'package:bloc_flutter_state/widgets/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_flutter_state/actions/gallery_events.dart';
import 'package:bloc_flutter_state/bloc/gallery_block.dart';
import 'package:bloc_flutter_state/widgets/login_view.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GalleryBloc>(
      create: (_) => GalleryBloc()
        ..add(
          const Initialize(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gallery'),
        ),
        body: BlocConsumer<GalleryBloc, GalleryState>(
          listener: (context, gState) {
            if (gState.isLoading) {
              LoadingScreen().show(
                context: context,
                text: 'Loading...',
              );
            } else {
              LoadingScreen().hide();
            }
            final authError = gState.authError;
            if (authError != null) {
              showAuthError(
                authError: authError,
                context: context,
              );
            }
          },
          builder: (context, gState) {
            if (gState is GalleryStateLoggedOut) {
              return LoginView(
                onLogin: (email, password) {
                  context.read<GalleryBloc>().add(
                        LogIn(
                          email: email,
                          password: password,
                        ),
                      );
                },
                toRegistration: () {
                  context.read<GalleryBloc>().add(
                        const GoToRegistration(),
                      );
                },
              );
            } else if (gState is GalleryStateLoggedIn) {
              return const GalleryView();
            } else if (gState is GalleryStateRegistration) {
              return RegisterView(
                onRegister: (email, password) {
                  context.read<GalleryBloc>().add(
                        Register(
                          email: email,
                          password: password,
                        ),
                      );
                },
                toLogin: () {
                  context.read<GalleryBloc>().add(
                        const GoToLogin(),
                      );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
