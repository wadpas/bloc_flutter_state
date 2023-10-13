import 'package:bloc_flutter_state/actions/notes_actions.dart';
import 'package:bloc_flutter_state/apis/login_api.dart';
import 'package:bloc_flutter_state/apis/notes_api.dart';
import 'package:bloc_flutter_state/bloc/notes_bloc.dart';
import 'package:bloc_flutter_state/models/notes.dart';
import 'package:bloc_flutter_state/states/notes_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

const Iterable<Note> mockNotes = [
  Note(title: 'Note 1'),
  Note(title: 'Note 2'),
  Note(title: 'Note 3'),
];

@immutable
class DummyNotesApi implements NotesApiProtocol {
  final LoginHandle acceptedLoginHandle;
  final Iterable<Note>? acceptedNotesLoginHandle;

  const DummyNotesApi({
    required this.acceptedLoginHandle,
    required this.acceptedNotesLoginHandle,
  });

  const DummyNotesApi.empty()
      : acceptedLoginHandle = const LoginHandle.foobar(),
        acceptedNotesLoginHandle = null;

  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) async {
    if (loginHandle == acceptedLoginHandle) {
      return acceptedNotesLoginHandle;
    } else {
      return null;
    }
  }
}

@immutable
class DummyLoginApi implements LoginApiProtocol {
  final String acceptedEmail;
  final String acceptedPassword;
  final LoginHandle handleToReturn;

  const DummyLoginApi({
    required this.acceptedEmail,
    required this.acceptedPassword,
    required this.handleToReturn,
  });

  const DummyLoginApi.empty()
      : acceptedEmail = '',
        acceptedPassword = '',
        handleToReturn = const LoginHandle.foobar();

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) async {
    if (email == acceptedEmail && password == acceptedPassword) {
      return handleToReturn;
    } else {
      return null;
    }
  }
}

const accLoginHandle = LoginHandle(token: 'token');

void main() {
  blocTest<NotesBloc, NotesState>(
    'NotesState is empty',
    build: () => NotesBloc(
        loginApi: const DummyLoginApi.empty(),
        notesAPi: const DummyNotesApi.empty(),
        accLoginHandle: accLoginHandle),
    verify: (notesState) => expect(
      notesState.state,
      const NotesState.empty(),
    ),
  );
  blocTest<NotesBloc, NotesState>(
    'Correct credentials',
    build: () => NotesBloc(
      loginApi: const DummyLoginApi(
        acceptedEmail: 'bar@baz.com',
        acceptedPassword: 'foo',
        handleToReturn: LoginHandle(token: 'token'),
      ),
      notesAPi: const DummyNotesApi.empty(),
      accLoginHandle: accLoginHandle,
    ),
    act: (appBloc) => appBloc.add(
      const LoginAction(
        email: 'bar@baz.com',
        password: 'foo',
      ),
    ),
    expect: () => [
      const NotesState(
        isLoading: true,
        loginError: null,
        loginHandle: null,
        fetchedNotes: null,
      ),
      const NotesState(
        isLoading: false,
        loginError: null,
        loginHandle: LoginHandle(token: 'token'),
        fetchedNotes: null,
      ),
    ],
  );

  blocTest<NotesBloc, NotesState>(
    'Incorrect credentials',
    build: () => NotesBloc(
      loginApi: const DummyLoginApi(
        acceptedEmail: 'foo@bar.com',
        acceptedPassword: 'baz',
        handleToReturn: LoginHandle(token: 'token'),
      ),
      notesAPi: const DummyNotesApi.empty(),
      accLoginHandle: accLoginHandle,
    ),
    act: (appBloc) => appBloc.add(
      const LoginAction(
        email: 'bar@baz.com',
        password: 'foo',
      ),
    ),
    expect: () => [
      const NotesState(
        isLoading: true,
        loginError: null,
        loginHandle: null,
        fetchedNotes: null,
      ),
      const NotesState(
        isLoading: false,
        loginError: LoginErrors.invalidHandle,
        loginHandle: null,
        fetchedNotes: null,
      ),
    ],
  );

  blocTest<NotesBloc, NotesState>(
    'Load some notes',
    build: () => NotesBloc(
      loginApi: const DummyLoginApi(
        acceptedEmail: 'foo@bar.com',
        acceptedPassword: 'baz',
        handleToReturn: LoginHandle(token: 'token'),
      ),
      notesAPi: const DummyNotesApi(
        acceptedLoginHandle: accLoginHandle,
        acceptedNotesLoginHandle: mockNotes,
      ),
      accLoginHandle: accLoginHandle,
    ),
    act: (appBloc) {
      appBloc.add(
        const LoginAction(
          email: 'foo@bar.com',
          password: 'baz',
        ),
      );
      appBloc.add(
        const LoadNotesAction(),
      );
    },
    expect: () => [
      const NotesState(
        isLoading: true,
        loginError: null,
        loginHandle: null,
        fetchedNotes: null,
      ),
      const NotesState(
        isLoading: false,
        loginError: null,
        loginHandle: accLoginHandle,
        fetchedNotes: null,
      ),
      const NotesState(
        isLoading: true,
        loginError: null,
        loginHandle: accLoginHandle,
        fetchedNotes: null,
      ),
      const NotesState(
        isLoading: false,
        loginError: null,
        loginHandle: accLoginHandle,
        fetchedNotes: mockNotes,
      ),
    ],
  );
}
