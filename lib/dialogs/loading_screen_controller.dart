import 'package:flutter/foundation.dart';

typedef CloseLoadindScreen = bool Function();
typedef UpdateLoadindScreen = bool Function(String text);

@immutable
class LoadindScreenController {
  final CloseLoadindScreen close;
  final UpdateLoadindScreen update;

  const LoadindScreenController({
    required this.close,
    required this.update,
  });
}
