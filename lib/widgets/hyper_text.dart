import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef TextBuilder = Widget Function(BuildContext context, String text);

/// A widget that animates text to appear character by character
/// similar to a typewriter animation.
class HyperText extends StatefulWidget {
  const HyperText({
    super.key,
    required this.text,
    required this.textBuilder,
    this.animationDuration = const Duration(milliseconds: 800),
    this.textStyle,
    this.shouldAnimate = false,
    this.animateOnInit = true,
    this.tickInterval = 2,
  });

  final String text;
  final Duration animationDuration;
  final TextStyle? textStyle;
  final bool shouldAnimate;
  final bool animateOnInit;
  final int tickInterval;
  final TextBuilder textBuilder;

  @override
  State<HyperText> createState() => _HyperTextState();
}

class _HyperTextState extends State<HyperText> with SingleTickerProviderStateMixin {
  late List<String> displayText = List.filled(widget.text.length, ' ');
  late List<String> finalText = widget.text.split('');

  late final Random _random = Random();
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    if (widget.animateOnInit) _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  int _currentCharIndex = 0;
  void _onTick(Duration elapsed) {
    final t = (elapsed.inMilliseconds / widget.animationDuration.inMilliseconds).clamp(0, 1);
    if (elapsed.inMilliseconds % widget.tickInterval != 0) return;

    int prevIndex = _currentCharIndex;
    setState(() {
      _currentCharIndex = ((widget.text.length) * t).floor();
      String randChar = String.fromCharCode(_random.nextInt(26) + 65);
      if (_currentCharIndex == prevIndex) {
        displayText[_currentCharIndex] = randChar;
      } else {
        displayText[_currentCharIndex - 1] = finalText[_currentCharIndex - 1];
      }

      if (t == 1) _ticker.stop();
    });
  }

  @override
  Widget build(BuildContext context) => widget.textBuilder(context, displayText.join());
}
