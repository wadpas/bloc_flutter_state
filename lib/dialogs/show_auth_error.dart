import 'package:bloc_flutter_state/dialogs/generic_dialog.dart';
import 'package:bloc_flutter_state/models/auth_errors.dart';
import 'package:flutter/material.dart';

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.title,
    content: authError.message,
    optionBuilder: () => {
      'OK': true,
    },
  );
}
