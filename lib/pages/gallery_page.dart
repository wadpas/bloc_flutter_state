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
    return Column(
      children: [
        LoginView(
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
        ),
        RegisterView(
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
        ),
      ],
    );
  }
}
