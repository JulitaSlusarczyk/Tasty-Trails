import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tasty_trails/ingredient.dart';

import 'collision_block.dart';

class Level extends World {
  final List<List<Ingredient>> ingredients;
  Level({required this.ingredients});
  late TiledComponent level;
  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('level-map.tmx', Vector2.all(16));

    add(level);

    final spawnPointsLayer =
      level.tileMap.getLayer<ObjectGroup>('SpawnPoints');
    final collisionsLayer =
      level.tileMap.getLayer<ObjectGroup>('Collisions');

    for (final collision in collisionsLayer?.objects ?? []) {
      final block = CollisionBlock(
        position: Vector2(collision.x, collision.y),
        size: Vector2(collision.width, collision.height),
      );
      collisionBlocks.add(block);
      add(block);
    }

    for (final spawnPoint in spawnPointsLayer?.objects ?? []) {
      final index = int.tryParse(spawnPoint.name);
      if (index != null && ingredients.length - 1 >= index) {
        (double, double) position = (spawnPoint.x, spawnPoint.y);
        Vector2 size = Vector2(spawnPoint.width, spawnPoint.height);
        for (int i = 0; i < ingredients[index].length; i++ ) {
          List<CollisionBlock> additionalCollisions = [];
          final ingredient = ingredients[index][i];
          ingredient.position = Vector2(position.$1, position.$2);
          ingredient.size = size;
          //change position for next ingredient
          position = (position.$1, position.$2 - spawnPoint.height);
          //add collisions
          if (i > additionalCollisions.length) {
            additionalCollisions.add(
              CollisionBlock(
                position: Vector2(
                    spawnPoint.x,
                    collisionBlocks[0].y - i * spawnPoint.height
                ),
                size: ingredient.size
              )
            );
          }
          ingredient.collisionBlocks = collisionBlocks + additionalCollisions;
          add(ingredient);
        }
      }
    }

    return super.onLoad();
  }
}