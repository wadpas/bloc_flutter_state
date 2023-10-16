import 'package:bloc_flutter_state/widgets/email_text_field.dart';
import 'package:bloc_flutter_state/widgets/login_button.dart';
import 'package:bloc_flutter_state/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  final OnLoginTapped onLoginTapped;

  const LoginView({
    super.key,
    required this.onLoginTapped,
  });

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EmailTextField(emailController: emailController),
              PasswordTextField(passwordController: passwordController),
              const SizedBox(height: 8),
              LoginButton(
                emailController: emailController,
                passwordController: passwordController,
                onLoginTapped: onLoginTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
