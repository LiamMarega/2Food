import 'package:flutter/widgets.dart';

class WavingHandEmoji extends StatefulWidget {
  const WavingHandEmoji({super.key});

  @override
  State<WavingHandEmoji> createState() => _WavingHandEmojiState();
}

class _WavingHandEmojiState extends State<WavingHandEmoji>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(
        count: 2,
        reverse: true,
      );

    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0, end: 0.3),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.3, end: -0.3),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.3, end: 0),
        weight: 1,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          child: const Text(
            '👋',
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }
}
