import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flame/effects.dart';

// Asset paths - make sure these match your pubspec.yaml
const String ronaldChild = 'ronald-child.png';
const String ronaldHello = 'ronald-hello.png';
const String ronaldWrong = 'ronald-wrong.png';
const String coinAsset = 'coin.png';
const String bookAsset = 'book.png';
const String bombAsset = 'bom.png';
const String controllerAsset = 'controller.png';
const String cloudAsset = 'cloud.png';

// Enum to represent the types of falling objects
enum ObjectType { coin, book, bomb, controller }

// ##################################################################
// #                 FLUTTER WIDGET (UI LAYER)                      #
// ##################################################################

class GameHopScreen extends StatefulWidget {
  const GameHopScreen({super.key});

  @override
  State<GameHopScreen> createState() => _GameHopScreenState();
}

class _GameHopScreenState extends State<GameHopScreen> {
  late final KwakKwakGame _game;

  @override
  void initState() {
    super.initState();
    _game = KwakKwakGame();
    // Listen for game over to show the dialog
    _game.isGameOver.addListener(_onGameOver);
  }

  @override
  void dispose() {
    _game.isGameOver.removeListener(_onGameOver);
    super.dispose();
  }

  void _onGameOver() {
    if (_game.isGameOver.value && mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: const Color(0xFFF8ECB8),
            title: Text(
              'Game Over',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
            content: Text(
              'Skor Akhir Kamu: ${_game.score.value}',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(fontSize: 20),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF78B96A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _game.restart();
                },
                child: Text(
                  'Main Lagi',
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEA8538),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Go back from game screen
                },
                child: Text(
                  'Keluar',
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _showSettingsModal() {
    // Pause the game when opening settings
    _game.pauseEngine();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xFFF8ECB8),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with back button
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close modal
                        _game.resumeEngine(); // Resume game
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Pengaturan',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 44), // Balance the back button
                  ],
                ),
                const SizedBox(height: 20),

                // Settings content
                _buildSettingItem(
                  icon: Icons.volume_up,
                  title: 'Suara',
                  subtitle: 'Atur volume game',
                  onTap: () {
                    // TODO: Implement sound settings
                  },
                ),
                const SizedBox(height: 16),

                _buildSettingItem(
                  icon: Icons.info_outline,
                  title: 'Tentang Game',
                  subtitle: 'Informasi game',
                  onTap: () {
                    // TODO: Implement about game
                  },
                ),
                const SizedBox(height: 16),

                _buildSettingItem(
                  icon: Icons.help_outline,
                  title: 'Cara Bermain',
                  subtitle: 'Panduan bermain',
                  onTap: () {
                    _showHowToPlay();
                  },
                ),
                const SizedBox(height: 24),

                // Exit to main menu button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEA8538),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close settings modal
                      Navigator.of(context).pop(); // Go back from game screen
                    },
                    child: Text(
                      'Kembali ke Menu Utama',
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF8B44A), width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: const Color(0xFF78B96A)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showHowToPlay() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xFFF8ECB8),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Cara Bermain',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 44),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHowToPlayItem(
                      '🪙 Coin & 📚 Book',
                      'Tangkap untuk +10 poin',
                      Colors.green,
                    ),
                    _buildHowToPlayItem(
                      '🎮 Controller',
                      'Hindari! -10 poin, jika -10,-20,-30 = lives -1',
                      Colors.orange,
                    ),
                    _buildHowToPlayItem(
                      '💣 Bom',
                      'Hindari! Langsung lives -1',
                      Colors.red,
                    ),
                    _buildHowToPlayItem(
                      '❤️ Lives',
                      'Game over jika lives = 0',
                      Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHowToPlayItem(String title, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6, right: 12),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The game widget
          GameWidget(game: _game),
          // The UI overlay
          _buildUiOverlay(),
          // The game controls
          _buildGameControls(),
        ],
      ),
    );
  }

  /// Builds the UI that sits on top of the game (score, lives, buttons)
  Widget _buildUiOverlay() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Menu Button
            _buildIconButton(Icons.more_horiz, () {
              _showSettingsModal();
            }),
            const SizedBox(width: 8),
            // Restart Button
            _buildIconButton(Icons.refresh, () => _game.restart()),
            const Spacer(),
            // Lives Display
            ValueListenableBuilder<int>(
              valueListenable: _game.lives,
              builder: (context, lives, child) {
                return Row(
                  children: List.generate(3, (index) {
                    return Icon(
                      index < lives ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 30,
                    );
                  }),
                );
              },
            ),
            const SizedBox(width: 16),
            // Score Display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFFF8B44A), width: 2),
              ),
              child: ValueListenableBuilder<int>(
                valueListenable: _game.score,
                builder: (context, score, child) {
                  return Row(
                    children: [
                      Image.asset(
                        'assets/images/$coinAsset',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        score.toString(),
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a single circular icon button for the UI overlay
  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Material(
      color: Colors.white.withOpacity(0.8),
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, size: 24, color: Colors.black87),
        ),
      ),
    );
  }

  /// Builds the left and right movement controls
  Widget _buildGameControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: GestureDetector(
                onTapDown: (_) => _game.player.startMovingLeft(),
                onTapUp: (_) => _game.player.stopMoving(),
                onTapCancel: () => _game.player.stopMoving(),
                child: const Icon(
                  Icons.arrow_circle_left_outlined,
                  size: 70,
                  color: Colors.white70,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: GestureDetector(
                onTapDown: (_) => _game.player.startMovingRight(),
                onTapUp: (_) => _game.player.stopMoving(),
                onTapCancel: () => _game.player.stopMoving(),
                child: const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 70,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ##################################################################
// #                   FLAME GAME (LOGIC LAYER)                     #
// ##################################################################

class KwakKwakGame extends FlameGame with HasCollisionDetection {
  late final Player player;
  final Random _random = Random();

  // Game state notifiers for the UI to listen to
  final ValueNotifier<int> score = ValueNotifier(0);
  final ValueNotifier<int> lives = ValueNotifier(3);
  final ValueNotifier<bool> isGameOver = ValueNotifier(false);

  @override
  Color backgroundColor() => const Color(0xFF81D4FA);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // FIXED: Disable debug mode in production for better performance
    debugMode = false;

    // Pre-load all images into the cache
    await images.loadAll([
      ronaldChild,
      ronaldHello,
      ronaldWrong,
      coinAsset,
      bookAsset,
      bombAsset,
      controllerAsset,
      cloudAsset,
    ]);

    // Add background and player
    add(Background());
    player = Player();
    add(player);

    // Start spawning objects and clouds
    add(TimerComponent(period: 1.2, repeat: true, onTick: _spawnObject));
    add(TimerComponent(period: 5.0, repeat: true, onTick: _spawnCloud));
  }

  void _spawnObject() {
    if (isGameOver.value) return;
    final type = ObjectType.values[_random.nextInt(ObjectType.values.length)];
    final xPosition = _random.nextDouble() * size.x;
    add(FallingObject(type, position: Vector2(xPosition, 0)));
  }

  void _spawnCloud() {
    if (isGameOver.value) return;
    final xPosition = size.x + 200;
    final yPosition = _random.nextDouble() * size.y * 0.4;
    add(Cloud(position: Vector2(xPosition, yPosition)));
  }

  void increaseScore(int amount, Vector2 position) {
    score.value += amount;
    add(ScoreIndicator(text: '+$amount', position: position));
  }

  void decreaseScore(int amount, Vector2 position) {
    final oldScore = score.value;
    score.value = max(0, score.value - amount);

    // FIXED: Logic untuk mengurangi lives berdasarkan skor negatif
    // Periksa apakah skor melewati kelipatan -10
    final newNegativeAmount = max(0, -score.value);
    final oldNegativeAmount = max(0, -(oldScore - amount));

    // Hitung berapa banyak kelipatan 10 yang terlewati
    final livesToLose = (newNegativeAmount ~/ 10) - (oldNegativeAmount ~/ 10);

    if (livesToLose > 0) {
      for (int i = 0; i < livesToLose; i++) {
        decreaseLives();
      }
    }

    add(
      ScoreIndicator(
        text: '-$amount',
        position: position,
        color: BasicPalette.red.paint(),
      ),
    );
  }

  void decreaseLives() {
    if (lives.value > 0) {
      lives.value--;
      if (lives.value == 0) {
        handleGameOver();
      }
    }
  }

  void handleGameOver() {
    if (!isGameOver.value) {
      isGameOver.value = true;
      // Pause the engine to stop all components
      pauseEngine();
    }
  }

  void restart() {
    // Reset game state
    score.value = 0;
    lives.value = 3;
    isGameOver.value = false;

    // Remove all existing game components except Background and Player
    children.whereType<FallingObject>().toList().forEach(
      (obj) => obj.removeFromParent(),
    );
    children.whereType<Cloud>().toList().forEach(
      (cloud) => cloud.removeFromParent(),
    );
    children.whereType<ScoreIndicator>().toList().forEach(
      (indicator) => indicator.removeFromParent(),
    );

    // Reset player position and state
    player.position = Vector2(size.x / 2, size.y - 150);
    player.current = 'idle';

    // Resume the engine
    resumeEngine();
  }
}

// ##################################################################
// #                     GAME COMPONENTS                            #
// ##################################################################

/// Player Component
class Player extends SpriteAnimationGroupComponent<String>
    with HasGameRef<KwakKwakGame>, CollisionCallbacks {
  final double _speed = 300.0;
  Vector2 _moveDirection = Vector2.zero();

  Player() : super(size: Vector2.all(120), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 150);

    final idleSprite = await gameRef.loadSprite(ronaldChild);
    final happySprite = await gameRef.loadSprite(ronaldHello);
    final wrongSprite = await gameRef.loadSprite(ronaldWrong);

    animations = {
      'idle': SpriteAnimation.spriteList([idleSprite], stepTime: 1),
      'happy': SpriteAnimation.spriteList([happySprite], stepTime: 1),
      'wrong': SpriteAnimation.spriteList([wrongSprite], stepTime: 1),
    };
    current = 'idle';

    // FIXED: Menggunakan RectangleHitbox dengan ukuran yang lebih kecil dan konsisten
    // untuk hitbox yang lebih akurat dan dapat diprediksi
    add(
      RectangleHitbox(
        size: Vector2(size.x * 0.6, size.y * 0.6),
        anchor: Anchor.center,
        position: Vector2(size.x * 0.5, size.y * 0.5),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameRef.isGameOver.value) {
      position += _moveDirection.normalized() * _speed * dt;
      position.x = position.x.clamp(size.x / 2, gameRef.size.x - size.x / 2);
    }
  }

  void startMovingLeft() => _moveDirection.x = -1;
  void startMovingRight() => _moveDirection.x = 1;
  void stopMoving() => _moveDirection.x = 0;

  void showReaction(String reaction) {
    current = reaction;
    Future.delayed(const Duration(milliseconds: 500), () {
      if (current == reaction && !gameRef.isGameOver.value) {
        current = 'idle';
      }
    });
  }
}

/// Falling Object Component
class FallingObject extends SpriteComponent
    with HasGameRef<KwakKwakGame>, CollisionCallbacks {
  final ObjectType type;
  final double _speed = 150.0;
  bool _hasCollided = false; // FIXED: Mencegah collision berganda

  FallingObject(this.type, {super.position})
    : super(size: Vector2.all(60), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(_getAssetPath());

    // FIXED: Menggunakan RectangleHitbox dengan ukuran yang konsisten
    add(
      RectangleHitbox(
        size: Vector2(size.x * 0.8, size.y * 0.8),
        anchor: Anchor.center,
        position: Vector2(size.x * 0.5, size.y * 0.5),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameRef.isGameOver.value) {
      position.y += _speed * dt;

      // Remove if it goes off-screen
      if (position.y > gameRef.size.y + size.y) {
        // FIXED: TIDAK mengurangi lives untuk objek yang terlewat
        // Hanya remove objek dari game tanpa penalty
        removeFromParent();
      }
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Player && !_hasCollided && !gameRef.isGameOver.value) {
      _hasCollided = true; // FIXED: Mencegah collision berganda
      _handleCollision(other);
    }
  }

  void _handleCollision(Player player) {
    switch (type) {
      case ObjectType.coin:
        gameRef.increaseScore(10, position);
        player.showReaction('happy');
        break;
      case ObjectType.book:
        gameRef.increaseScore(10, position);
        player.showReaction('happy');
        break;
      case ObjectType.controller:
        gameRef.decreaseScore(10, position);
        player.showReaction('wrong');
        break;
      case ObjectType.bomb:
        gameRef
            .decreaseLives(); // FIXED: Hanya kurangi lives, game over akan dicek di decreaseLives()
        player.showReaction('wrong');
        break;
    }
    removeFromParent();
  }

  String _getAssetPath() {
    switch (type) {
      case ObjectType.coin:
        return coinAsset;
      case ObjectType.book:
        return bookAsset;
      case ObjectType.bomb:
        return bombAsset;
      case ObjectType.controller:
        return controllerAsset;
    }
  }
}

/// Background Component
class Background extends PositionComponent with HasGameRef<KwakKwakGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // The green ground at the bottom
    add(
      RectangleComponent(
        position: Vector2(0, gameRef.size.y - 100),
        size: Vector2(gameRef.size.x, 100),
        paint: BasicPalette.green.withAlpha(150).paint(),
      ),
    );
  }
}

/// Cloud Component
class Cloud extends SpriteComponent with HasGameRef<KwakKwakGame> {
  Cloud({super.position})
    : super(size: Vector2(150, 80), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(cloudAsset);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameRef.isGameOver.value) {
      position.x -= 30 * dt; // Move slowly to the left
      if (position.x < -size.x) {
        removeFromParent();
      }
    }
  }
}

/// Score Indicator Component
class ScoreIndicator extends TextComponent
    with HasGameRef<KwakKwakGame>
    implements OpacityProvider {
  ScoreIndicator({required String text, super.position, Paint? color})
    : super(
        text: text,
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: GoogleFonts.nunito(
            fontSize: 24,
            color: color?.color ?? Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  double get opacity => (textRenderer as TextPaint).style.color!.opacity;

  @override
  set opacity(double value) {
    final originalStyle = (textRenderer as TextPaint).style;
    textRenderer = TextPaint(
      style: originalStyle.copyWith(
        color: originalStyle.color!.withOpacity(value),
      ),
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Animate the text moving up and fading out
    final endPosition = position - Vector2(0, 50);
    add(
      MoveToEffect(
        endPosition,
        EffectController(duration: 1.0),
        onComplete: () => removeFromParent(),
      ),
    );
    add(OpacityEffect.fadeOut(EffectController(duration: 1.0)));
  }
}
