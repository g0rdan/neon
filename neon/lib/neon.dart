library neon;

import 'package:flutter/material.dart';

class Neon extends StatefulWidget {
  Neon({Key key}) : super(key: key);

  @override
  _NeonState createState() => _NeonState();
}

class _NeonState extends State<Neon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Hello World",
        style: TextStyle(
            fontFamily: Fonts.Samarin, color: Colors.purple, fontSize: 60.0),
      ),
    );
  }
}

class Fonts {
  static const String Beon = 'packages/neon/Beon';
  static const String Monoton = 'packages/neon/Monoton';
  static const String Automania = 'packages/neon/Automania';
  static const String LasEnter = 'packages/neon/LasEnter';
  static const String TextMeOne = 'packages/neon/TextMeOne';
  static const String NightClub70s = 'packages/neon/Night-Club-70s';
  static const String Membra = 'packages/neon/Membra';
  static const String Samarin = 'packages/neon/Samarin';
}
