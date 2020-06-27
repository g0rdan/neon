import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neon/neon.dart';

class NeonChar extends StatefulWidget {
  final String letter;
  final NeonFonts font;
  final double fontSize;
  final EnegryLevel energyLevel;

  NeonChar(this.letter, this.font, this.fontSize, this.energyLevel, {Key key})
      : super(key: key);

  @override
  _NeonCharState createState() => _NeonCharState();
}

class _NeonCharState extends State<NeonChar> {
  String get letter => widget.letter;
  NeonFonts get font => widget.font;
  double get fontSize => widget.fontSize;
  EnegryLevel get enegryLevel => widget.energyLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      letter,
      style: TextStyle(
          fontFamily: _extractFont(font),
          color: _getPrimartColor(enegryLevel),
          fontSize: fontSize,
          shadows: _getShadows(enegryLevel)),
    ));
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

  List<Shadow> _getShadows(EnegryLevel enegryLevel) {
    if (enegryLevel == EnegryLevel.Low) {
      return [
        Shadow(color: Colors.blue[400], blurRadius: 5),
      ];
    } else {
      return [
        Shadow(color: Colors.blue[200], blurRadius: 10),
        Shadow(color: Colors.blue[300], blurRadius: 30),
        Shadow(color: Colors.blue[400], blurRadius: 60),
      ];
    }
  }

  Color _getPrimartColor(EnegryLevel enegryLevel) {
    return enegryLevel == EnegryLevel.Low ? Colors.blue[300] : Colors.blue[50];
  }

  void _waitForHighPower() async {
    Future.delayed(Duration(milliseconds: _random(150, 300)), () {
      setState(() {
        // _enegryLevel = EnegryLevel.High;
      });
    }).then((value) {
      _waitForLowPower();
    });
  }

  void _waitForLowPower() {
    Future.delayed(Duration(milliseconds: _random(500, 2500)), () {
      setState(() {
        // _enegryLevel = EnegryLevel.Low;
      });
    }).then((value) {
      _waitForHighPower();
    });
  }

  int _random(int min, int max) {
    var rn = Random();
    return min + rn.nextInt(max - min);
  }
}
