import 'package:bloc_flutter_state/data/strings.dart';
import 'package:bloc_flutter_state/dialogs/generic_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef OnLoginTapped = void Function(
  String email,
  String password,
);

extension IfDebugging on String {
  String? get ifDebugging => kDebugMode ? this : null;
}

class LoginView extends HookWidget {
  final OnLoginTapped onLoginTapped;
  final Function? toRegistration;

  const LoginView({
    super.key,
    required this.onLoginTapped,
    this.toRegistration,
  });

  @override
  Widget build(BuildContext context) {
    final emailController =
        useTextEditingController(text: 'foo@bar.com'.ifDebugging);
    final passwordController = useTextEditingController(text: 'foobar');
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: enterYourEmailHere,
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: enterYourPasswordHere,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  if (email.isEmpty || password.isEmpty) {
                    showGenericDialog(
                      context: context,
                      title: emailOrPasswordEmptyDialogTitle,
                      content: emailOrPasswordEmptyDescription,
                      optionBuilder: () => {ok: true},
                    );
                  } else {
                    onLoginTapped(email, password);
                  }
                },
                child: const Text(login),
              ),
              if (toRegistration != null)
                ElevatedButton(
                  onPressed: () {
                    toRegistration!();
                  },
                  child: const Text('To Registration'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
