import 'package:bloc_flutter_state/actions/notes_actions.dart';
import 'package:bloc_flutter_state/apis/login_api.dart';
import 'package:bloc_flutter_state/apis/notes_api.dart';
import 'package:bloc_flutter_state/bloc/notes_bloc.dart';
import 'package:bloc_flutter_state/dialogs/generic_dialog.dart';
import 'package:bloc_flutter_state/dialogs/loading_screen.dart';
import 'package:bloc_flutter_state/models/notes.dart';
import 'package:bloc_flutter_state/data/strings.dart';
import 'package:bloc_flutter_state/states/notes_state.dart';
import 'package:bloc_flutter_state/widgets/iterable_list_view.dart';
import 'package:bloc_flutter_state/widgets/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(
        loginApi: LoginApi(),
        notesAPi: NotesApi(),
        accLoginHandle: const LoginHandle.foobar(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
        ),
        body: BlocConsumer<NotesBloc, NotesState>(
          listener: (context, notesState) {
            if (notesState.isLoading) {
              LoadingScreen().show(
                context: context,
                text: pleaseWait,
              );
            } else {
              LoadingScreen().hide();
            }
            final loginError = notesState.loginError;
            if (loginError != null) {
              showGenericDialog<bool>(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionBuilder: () => {ok: true},
              );
            }
            if (notesState.isLoading == false &&
                notesState.loginError == null &&
                notesState.loginHandle == const LoginHandle.foobar() &&
                notesState.fetchedNotes == null) {
              context.read<NotesBloc>().add(
                    const LoadNotesAction(),
                  );
            }
          },
          builder: (context, notesState) {
            final notes = notesState.fetchedNotes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, password) {
                  context.read<NotesBloc>().add(
                        LoginAction(
                          email: email,
                          password: password,
                        ),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
