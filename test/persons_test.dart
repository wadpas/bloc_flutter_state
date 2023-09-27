import 'package:bloc_flutter_state/actions/persons_actions.dart';
import 'package:bloc_flutter_state/bloc/persons_bloc.dart';
import 'package:bloc_flutter_state/models/person.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPersons1 = [
  Person(name: 'Foo 1', age: 20),
  Person(name: 'Baz 1', age: 25),
];

const mockedPersons2 = [
  Person(name: 'Foo 2', age: 30),
  Person(name: 'Baz 2', age: 35),
];

Future<Iterable<Person>> mockGetPersons1(String _) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> mockGetPersons2(String _) =>
    Future.value(mockedPersons2);

void main() {
  group('Testing bloc', () {
    late PersonsBloc bloc;

    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc, FetchResult?>(
      'Test init state',
      build: () => bloc,
      verify: (bloc) => expect(bloc.state, null),
    );

    blocTest<PersonsBloc, FetchResult?>(
      'Mock Persons1',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url',
            loader: mockGetPersons1,
          ),
        );
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url',
            loader: mockGetPersons1,
          ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPersons1,
          isFromCache: false,
        ),
        const FetchResult(
          persons: mockedPersons1,
          isFromCache: true,
        ),
      ],
    );
    blocTest<PersonsBloc, FetchResult?>(
      'Mock Persons2',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url',
            loader: mockGetPersons2,
          ),
        );
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url',
            loader: mockGetPersons2,
          ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPersons2,
          isFromCache: false,
        ),
        const FetchResult(
          persons: mockedPersons2,
          isFromCache: true,
        ),
      ],
    );
  });
}
