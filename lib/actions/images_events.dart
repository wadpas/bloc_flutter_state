import 'package:flutter/foundation.dart';

@immutable
abstract class ImagesEvent {
  const ImagesEvent();
}

@immutable
class LoadNextUrlEvent implements ImagesEvent {
  const LoadNextUrlEvent();
}
