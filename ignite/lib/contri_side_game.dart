import 'package:flame/game.dart';
import 'components/player.dart';
import '../helpers/direction.dart';
import 'components/world.dart';
import 'dart:ui';
import 'components/world_collidable.dart';
import 'helpers/map_loader.dart';
import 'package:flame/components.dart';

class ContriSideGame extends FlameGame with HasCollidables {
  final Player _player = Player();
  final World _world = World();
  // final WhiteBarrel _whiteBarrel =
  //     WhiteBarrel(Vector2(50, 50), Vector2(1250, 1250));

  // projectMarkers

  @override
  Future<void> onLoad() async {
    await add(_world);
    // await add(_whiteBarrel);

    add(_player);
    addWorldCollision();

    // print(_world.size.x);
    // print(_world.size.y);

    _player.position = _world.size / 2;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void addWorldCollision() async =>
      (await MapLoader.readContriSideCollisionMap()).forEach((rect) {
        // print(rect.toString());
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }
}
