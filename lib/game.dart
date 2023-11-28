import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:tasty_trails/level.dart';

class TastyTrails extends FlameGame {

  late CameraComponent cam;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    final myWorld = Level();

    cam = CameraComponent.withFixedResolution(
        world: myWorld, width: 360, height: 640)
      ..priority = 0
      ..viewfinder.anchor = Anchor.topLeft;

    addAll([cam, myWorld]);

    return super.onLoad();
  }
}