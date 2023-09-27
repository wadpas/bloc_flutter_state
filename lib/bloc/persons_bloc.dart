import 'package:bloc_flutter_state/actions/persons_actions.dart';
import 'package:bloc_flutter_state/models/person.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqual(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isFromCache;
  const FetchResult({
    required this.persons,
    required this.isFromCache,
  });

  @override
  String toString() =>
      'FetchResults (isFromCache = $isFromCache, persons = $persons)';

  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqual(other.persons) && isFromCache == other.isFromCache;

  @override
  int get hashCode => Object.hash(persons, isFromCache);
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final cachedPersons = _cache[url]!;
        final result = FetchResult(
          persons: cachedPersons,
          isFromCache: true,
        );
        emit(result);
      } else {
        final loader = event.loader;
        final persons = await loader(url);
        _cache[url] = persons;
        final result = FetchResult(
          persons: persons,
          isFromCache: false,
        );
        emit(result);
      }
    });
  }
}
