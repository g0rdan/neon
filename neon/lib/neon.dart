library neon;

import 'dart:math';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:neon/neon_exception.dart';

import 'neon_char.dart';

enum EnergyLevel { Low, High }

class Neon extends StatefulWidget {
  final String text;
  final MaterialColor color;
  final double fontSize;
  final NeonFont font;
  final bool flickeringText;
  final List<int> flickeringLetters;
  final double blurRadius;
  final bool glowing;
  final Duration glowingDuration;
  final TextStyle textStyle;

  Neon(
      {@required this.text,
      @required this.color,
      @required this.font,
      this.fontSize = 30,
      this.blurRadius = 30,
      this.flickeringText = false,
      this.flickeringLetters,
      this.glowing = false,
      this.glowingDuration = const Duration(milliseconds: 1500),
      this.textStyle,
      Key key})
      : super(key: key);

  @override
  _NeonState createState() => _NeonState();
}

class _NeonState extends State<Neon> with SingleTickerProviderStateMixin {
  List<EnergyLevel> _enegryLevels;
  CancelableOperation _cancelableWaitingForLowPower;
  CancelableOperation _cancelableWaitingForHighPower;

  String get text => widget.text;

  MaterialColor get color => widget.color;

  double get fontSize => widget.fontSize;

  NeonFont get font => widget.font;

  bool get flickeringText => widget.flickeringText;

  List<int> get flickeringLetters => widget.flickeringLetters;

  double get blurRadius => widget.blurRadius;

  bool get glowing => widget.glowing;

  Duration get glowingDuration => widget.glowingDuration;

  TextStyle get textStyle => widget.textStyle;

  @override
  void initState() {
    _enegryLevels = List(text.length);
    // initial high level of the light
    _changeEnergyLevels(EnergyLevel.High);
    _checkIfFlickeringNeeded();
    super.initState();
  }

  @override
  void didUpdateWidget(Neon oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkIfFlickeringNeeded();
  }

  @override
  void dispose() {
    _cancelableWaitingForLowPower?.cancel();
    _cancelableWaitingForHighPower?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _preprocessText(),
    ));
  }

  void _checkIfFlickeringNeeded() {
    if (flickeringText ||
        (flickeringLetters != null && flickeringLetters.length > 0)) {
      _cancelableWaitingForLowPower = CancelableOperation.fromFuture(
        _waitForLowPower(),
        onCancel: () => {debugPrint('onCancel')},
      );
    } else {
      _cancelableWaitingForLowPower?.cancel();
      _cancelableWaitingForHighPower?.cancel();
    }
  }

  List<NeonChar> _preprocessText() {
    assert(text != null);

    List<NeonChar> list = [];
    for (var i = 0; i < text.length; i++) {
      list.add(NeonChar(text[i], color, font, fontSize, _enegryLevels[i],
          blurRadius, glowing, glowingDuration, textStyle));
    }
    return list;
  }

  Future<void> _waitForHighPower() {
    return Future.delayed(Duration(milliseconds: _random(150, 600)), () {
      _changeEnergyLevels(EnergyLevel.High, flickeringLetters);
    }).then((value) {
      _cancelableWaitingForLowPower = CancelableOperation.fromFuture(
        _waitForLowPower(),
        onCancel: () => {debugPrint('onCancel')},
      );
    });
  }

  Future<void> _waitForLowPower() {
    return Future.delayed(Duration(milliseconds: _random(500, 5000)), () {
      _changeEnergyLevels(EnergyLevel.Low, flickeringLetters);
    }).then((value) {
      _cancelableWaitingForHighPower = CancelableOperation.fromFuture(
        _waitForHighPower(),
        onCancel: () => {debugPrint('onCancel')},
      );
    });
  }

  void _changeEnergyLevels(EnergyLevel level, [List<int> indexes]) {
    setState(() {
      if (indexes == null || indexes.length == 0) {
        for (var i = 0; i < text.length; i++) {
          _enegryLevels[i] = level;
        }
      } else {
        for (var index in indexes) {
          if (index > text.length - 1) {
            throw NeonException(
                'Index of flickering letter cannot be more than length of the text');
          }
          _enegryLevels[index] = level;
        }
      }
    });
  }

  int _random(int min, int max) {
    var rn = Random();
    return min + rn.nextInt(max - min);
  }
}

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
          // The color must be set to white for this to work
          color: Colors.white,
          fontSize: 40,
        ),
      ),
    );
  }
}

enum NeonFont {
  Beon,
  Monoton,
  Automania,
  LasEnter,
  TextMeOne,
  NightClub70s,
  Membra,
  Samarin,
  Cyberpunk
}

extension Font on NeonFont {
  String get name {
    switch (this) {
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
}
