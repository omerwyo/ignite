import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class World extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('contri_map.png');
    size = sprite!.originalSize;
    return super.onLoad();
  }
}

class WhiteBarrel extends SpriteComponent with HasGameRef {
  WhiteBarrel(size, position)
      : super(
            priority: 1,
            size: size,
            position: position); // Set priority to be above

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load('barrel_white.png');

    return super.onLoad();
  }
}
