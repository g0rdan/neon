import 'package:flutter/material.dart';

class WallBg extends StatelessWidget {
  const WallBg({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image(
              image: AssetImage('assets/images/wall.png'),
            ),
          ),
        ),
        Container(color: Colors.black.withOpacity(0.7))
      ],
    );
  }
}
