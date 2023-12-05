import 'dart:async';

import 'package:flame/components.dart';
import 'package:tasty_trails/collision_block.dart';
import 'package:tasty_trails/game.dart';

class Ingredient extends SpriteAnimationComponent with HasGameRef<TastyTrails> {
  Ingredient({super.position, super.size});

  late final SpriteAnimation ingredientAnimation;
  final double stepTime = 0.05;
  final double gravity = 9.8;
  Vector2 velocity = Vector2.zero();

  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache("strawberry.png"),
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: stepTime,
            textureSize: Vector2.all(32))
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    applyGravity(dt);
    checkVerticalCollisions();
    super.update(dt);
  }

  void applyGravity(double dt) {
    velocity.y += gravity;
    position.y += velocity.y * dt;
  }

  void checkVerticalCollisions() {
    for (final block in collisionBlocks) {
      if (checkCollision(this, block)) {
        if(velocity.y > 0) {
          velocity.y = 0;
          position.y = block.y - width;
          break;
        }
        if (velocity.y < 0) {
          velocity.y = 0;
          position.y = block.y + block.height;
          break;
        }
      }
    }
  }
}

bool checkCollision(player, block) {
  final playerX = player.position.x;
  final playerY = player.position.y;
  final playerWidth = player.width;
  final playerHeight = player.height;

  final blockX = block.position.x;
  final blockY = block.position.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  final fixedX = player.scale.x < 0
      ? playerX - player.width
      : playerX;
  final fixedY = playerY;

  return (
      fixedY < blockY + blockHeight &&
          playerY + playerHeight > blockY &&
          fixedX < blockX + blockWidth &&
          fixedX + playerWidth > blockX
  );
}