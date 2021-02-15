import 'package:flutter/material.dart';
import 'package:neon/neon.dart';

class NeonChar extends StatefulWidget {
  final String letter;
  final MaterialColor color;
  final NeonFont font;
  final double fontSize;
  final EnergyLevel energyLevel;
  final double blurRadius;
  final bool glowing;
  final Duration glowingDuration;
  final TextStyle textStyle;

  NeonChar(this.letter, this.color, this.font, this.fontSize, this.energyLevel,
      this.blurRadius, this.glowing, this.glowingDuration, this.textStyle,
      {Key key})
      : super(key: key);

  @override
  _NeonCharState createState() => _NeonCharState();
}

class _NeonCharState extends State<NeonChar> with TickerProviderStateMixin {
  AnimationController _shadowController;

  String get letter => widget.letter;
  NeonFont get font => widget.font;
  double get fontSize => widget.fontSize;
  EnergyLevel get enegryLevel => widget.energyLevel;
  MaterialColor get color => widget.color;
  double get blurRadius => widget.blurRadius;
  bool get glowing => widget.glowing;
  Duration get glowingDuration => widget.glowingDuration;
  TextStyle get textStyle => widget.textStyle;

  @override
  void initState() {
    _shadowController = AnimationController(
      duration: glowingDuration,
      vsync: this,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(NeonChar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (glowing) {
      _shadowController.repeat(min: 0.2, max: 1, reverse: true);
    }
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
                  var radius = _shadowController.value * blurRadius * 1.5;
                  return Text(letter,
                      style: textStyle != null
                          ? textStyle.copyWith(
                              shadows: _getShadows(enegryLevel, radius))
                          : TextStyle(
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

  String _extractFont(NeonFont font) {
    assert(font != null);

    switch (font) {
      case NeonFont.Automania:
        return 'packages/neon/Automania';
      case NeonFont.Beon:
        return 'packages/neon/Beon';
      case NeonFont.Cyberpunk:
        return 'packages/neon/Cyberpunk';
      case NeonFont.LasEnter:
        return 'packages/neon/LasEnter';
      case NeonFont.Membra:
        return 'packages/neon/Membra';
      case NeonFont.Monoton:
        return 'packages/neon/Monoton';
      case NeonFont.NightClub70s:
        return 'packages/neon/NightClub70s';
      case NeonFont.Samarin:
        return 'packages/neon/Samarin';
      case NeonFont.TextMeOne:
        return 'packages/neon/TextMeOne';
      default:
        return 'packages/neon/Beon';
    }
  }

  List<Shadow> _getShadows(EnergyLevel enegryLevel, double radius) {
    if (enegryLevel == EnergyLevel.Low) {
      return [
        Shadow(color: color[400], blurRadius: radius / 6),
      ];
    } else {
      return [
        Shadow(color: color[300], blurRadius: radius / 2),
        Shadow(color: color[400], blurRadius: radius),
        Shadow(color: color[500], blurRadius: radius * 3),
      ];
    }
  }

  Color _getPrimartColor(EnergyLevel enegryLevel) {
    return enegryLevel == EnergyLevel.Low ? color[300] : color[50];
  }
}
