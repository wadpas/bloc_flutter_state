import 'package:bloc_flutter_state/actions/notes_actions.dart';
import 'package:bloc_flutter_state/apis/login_api.dart';
import 'package:bloc_flutter_state/apis/notes_api.dart';
import 'package:bloc_flutter_state/models/notes.dart';
import 'package:bloc_flutter_state/states/notes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesBloc extends Bloc<NotesAction, NotesState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesAPi;
  final LoginHandle accLoginHandle;

  NotesBloc({
    required this.loginApi,
    required this.notesAPi,
    required this.accLoginHandle,
  }) : super(const NotesState.empty()) {
    on<LoginAction>(
      (event, emit) async {
        emit(
          const NotesState(
            isLoading: true,
            loginError: null,
            loginHandle: null,
            fetchedNotes: null,
          ),
        );
        final loginHandle = await loginApi.login(
          email: event.email,
          password: event.password,
        );
        emit(
          NotesState(
            isLoading: false,
            loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
      },
    );
    on<LoadNotesAction>(
      (event, emit) async {
        emit(
          NotesState(
            isLoading: true,
            loginError: null,
            loginHandle: state.loginHandle,
            fetchedNotes: null,
          ),
        );
        final loginHandle = state.loginHandle;
        if (loginHandle != accLoginHandle) {
          emit(
            NotesState(
              isLoading: false,
              loginError: LoginErrors.invalidHandle,
              loginHandle: loginHandle,
              fetchedNotes: null,
            ),
          );
        } else {
          final notes = await notesAPi.getNotes(loginHandle: loginHandle!);
          emit(
            NotesState(
              isLoading: false,
              loginError: null,
              loginHandle: loginHandle,
              fetchedNotes: notes,
            ),
          );
        }
      },
    );
  }
}
