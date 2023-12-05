import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:tasty_trails/ingredient.dart';
import 'package:tasty_trails/level.dart';

class TastyTrails extends FlameGame {
  late CameraComponent cam;
  final List<List<Ingredient>> ingredients = [
    [
      Ingredient(),
      Ingredient(),
      Ingredient(),
      Ingredient(),
      Ingredient(),
    ],
    [
      Ingredient(),
      Ingredient()
    ],
    [
      Ingredient(),
      Ingredient()
    ],
  ];

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    final myWorld = Level(ingredients: ingredients);

    cam = CameraComponent.withFixedResolution(
        world: myWorld, width: 320, height: 608)
      ..priority = 0
      ..viewfinder.anchor = Anchor.topLeft;

    addAll([cam, myWorld]);

    return super.onLoad();
  }
}