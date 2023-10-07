import 'package:flutter/foundation.dart';

typedef CLoseLoadindScreen = bool Function();
typedef UpdateLoadindScreen = bool Function(String text);

@immutable
class LoadindScreenController {
  final CLoseLoadindScreen close;
  final UpdateLoadindScreen update;

  const LoadindScreenController({
    required this.close,
    required this.update,
  });
}
