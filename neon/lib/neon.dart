library neon;

import 'package:flutter/material.dart';

class Neon extends StatefulWidget {
  final String text;
  final Color color;

  Neon(this.text, this.color, {Key key}) : super(key: key);

  @override
  _NeonState createState() => _NeonState();
}

class _NeonState extends State<Neon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        widget.text,
        style: TextStyle(
            fontFamily: Fonts.Beon,
            color: Colors.blue[100],
            fontSize: 60.0,
            shadows: [
              Shadow(color: Colors.blue[200], blurRadius: 10),
              Shadow(color: Colors.blue[300], blurRadius: 20),
              Shadow(color: Colors.blue[400], blurRadius: 30),
            ]),
      ),
      // GradientText(
      //   'Hello Flutter',
      //   gradient: LinearGradient(colors: [
      //     Colors.blue.shade400,
      //     Colors.blue.shade900,
      //     Colors.green,
      //   ]),
      // ),

      //     RichText(
      //   text: TextSpan(
      //     text: widget.text,
      //     style: DefaultTextStyle.of(context).style,
      //     children: <TextSpan>[
      //       TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
      //       TextSpan(text: ' world!'),
      //     ],
      //   ),
      // )
    );
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
