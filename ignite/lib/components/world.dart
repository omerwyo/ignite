import 'package:flame/components.dart';

class World extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('contriside_background.png');
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
