import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_flutter_state/actions/persons_actions.dart';
import 'package:bloc_flutter_state/bloc/persons_bloc.dart';
import 'package:bloc_flutter_state/models/person.dart';

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((resp) => resp.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class PersonsPage extends StatelessWidget {
  const PersonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bloc Page'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<PersonsBloc>().add(
                          const LoadPersonsAction(
                            url: persons1Url,
                            loader: getPersons,
                          ),
                        );
                  },
                  child: const Text('Persons 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<PersonsBloc>().add(
                          const LoadPersonsAction(
                            url: persons2Url,
                            loader: getPersons,
                          ),
                        );
                  },
                  child: const Text('Persons 2'),
                ),
              ],
            ),
            BlocBuilder<PersonsBloc, FetchResult?>(
              buildWhen: (previous, current) {
                return previous?.persons != current?.persons;
              },
              builder: (context, fetchResult) {
                final persons = fetchResult?.persons;
                if (persons == null) {
                  return const SizedBox();
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: persons.length,
                        itemBuilder: (context, index) {
                          final person = persons[index]!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: ListTile(
                              title: Text(person.name),
                              trailing: Text(
                                person.age.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        }),
                  );
                }
              },
            )
          ],
        ));
  }
}
