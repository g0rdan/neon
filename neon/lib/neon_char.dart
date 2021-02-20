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
  EnergyLevel get energyLevel => widget.energyLevel;
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
                              shadows: _getShadows(energyLevel, radius))
                          : TextStyle(
                              fontFamily: _extractFont(font),
                              color: _getPrimartColor(energyLevel),
                              fontSize: fontSize,
                              shadows: _getShadows(energyLevel, radius)));
                },
              )
            : Text(letter,
                style: TextStyle(
                    fontFamily: _extractFont(font),
                    color: _getPrimartColor(energyLevel),
                    fontSize: fontSize,
                    shadows: _getShadows(energyLevel, blurRadius))));
  }

  String _extractFont(NeonFont font) {
    assert(font != null);

    return font.name;
  }

  List<Shadow> _getShadows(EnergyLevel energyLevel, double radius) {
    if (energyLevel == EnergyLevel.Low) {
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
