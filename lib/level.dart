import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import 'collision_block.dart';

class Level extends World {
  late TiledComponent level;
  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('level-map.tmx', Vector2.all(16));

    add(level);

    final collisionsLayer =
        level.tileMap.getLayer<ObjectGroup>('border');

    for (final collision in collisionsLayer?.objects ?? []) {
      final block = CollisionBlock(
        position: Vector2(collision.x, collision.y),
        size: Vector2(collision.width, collision.height),
      );
      collisionBlocks.add(block);
      add(block);
    }

    return super.onLoad();
  }
}