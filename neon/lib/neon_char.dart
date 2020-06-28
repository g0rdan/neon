import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neon/neon.dart';

class NeonChar extends StatefulWidget {
  final String letter;
  final MaterialColor color;
  final NeonFonts font;
  final double fontSize;
  final EnegryLevel energyLevel;
  final double blurRadius;
  final bool glowing;
  final Duration glowingDuration;

  NeonChar(this.letter, this.color, this.font, this.fontSize, this.energyLevel,
      this.blurRadius, this.glowing, this.glowingDuration,
      {Key key})
      : super(key: key);

  @override
  _NeonCharState createState() => _NeonCharState();
}

class _NeonCharState extends State<NeonChar> with TickerProviderStateMixin {
  AnimationController _shadowController;

  String get letter => widget.letter;
  NeonFonts get font => widget.font;
  double get fontSize => widget.fontSize;
  EnegryLevel get enegryLevel => widget.energyLevel;
  MaterialColor get color => widget.color;
  double get blurRadius => widget.blurRadius;
  bool get glowing => widget.glowing;
  Duration get glowingDuration => widget.glowingDuration;

  @override
  void initState() {
    if (glowing) {
      _shadowController = AnimationController(
        duration: glowingDuration,
        vsync: this,
      );
      _shadowController.repeat(min: 0.2, max: 1, reverse: true);
    }

    super.initState();
  }

  @override
  void dispose() {
    _shadowController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: glowing
            ? AnimatedBuilder(
                animation: _shadowController,
                builder: (context, child) {
                  var radius = _shadowController.value * blurRadius;
                  return Text(letter,
                      style: TextStyle(
                          fontFamily: _extractFont(font),
                          color: _getPrimartColor(enegryLevel),
                          fontSize: fontSize,
                          shadows: _getShadows(enegryLevel, radius)));
                },
              )
            : Text(letter,
                style: TextStyle(
                    fontFamily: _extractFont(font),
                    color: _getPrimartColor(enegryLevel),
                    fontSize: fontSize,
                    shadows: _getShadows(enegryLevel, blurRadius))));
  }

  String _extractFont(NeonFonts font) {
    assert(font != null);

    switch (font) {
      case NeonFonts.Automania:
        return 'packages/neon/Automania';
      case NeonFonts.Beon:
        return 'packages/neon/Beon';
      case NeonFonts.Cyberpunk:
        return 'packages/neon/Cyberpunk';
      case NeonFonts.LasEnter:
        return 'packages/neon/LasEnter';
      case NeonFonts.Membra:
        return 'packages/neon/Membra';
      case NeonFonts.Monoton:
        return 'packages/neon/Monoton';
      case NeonFonts.NightClub70s:
        return 'packages/neon/NightClub70s';
      case NeonFonts.Samarin:
        return 'packages/neon/Samarin';
      case NeonFonts.TextMeOne:
        return 'packages/neon/TextMeOne';
      default:
        return 'packages/neon/Beon';
    }
  }

  List<Shadow> _getShadows(EnegryLevel enegryLevel, double radius) {
    if (enegryLevel == EnegryLevel.Low) {
      return [
        Shadow(color: color[400], blurRadius: radius / 6),
      ];
    } else {
      return [
        Shadow(color: color[200], blurRadius: radius / 3),
        Shadow(color: color[300], blurRadius: radius),
        Shadow(color: color[400], blurRadius: radius * 2),
      ];
    }
  }

  Color _getPrimartColor(EnegryLevel enegryLevel) {
    return enegryLevel == EnegryLevel.Low ? color[300] : color[50];
  }
}
