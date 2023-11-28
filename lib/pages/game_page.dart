import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:tasty_trails/game.dart';

TastyTrails tastyTrailsGame = TastyTrails();

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: tastyTrailsGame,
    );
  }
}
