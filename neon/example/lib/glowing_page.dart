import 'package:example/wall_bg.dart';
import 'package:flutter/material.dart';
import 'package:neon/neon.dart';

class GlowingPage extends StatefulWidget {
  GlowingPage({Key key}) : super(key: key);

  @override
  _GlowingPageState createState() => _GlowingPageState();
}

class _GlowingPageState extends State<GlowingPage> {
  double _blurRadius = 10;
  bool _auto = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            WallBg(),
            Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      child: Neon(
                        text: 'Flutter',
                        color: Colors.indigo,
                        fontSize: 50,
                        font: NeonFont.Beon,
                        blurRadius: _blurRadius,
                        glowing: _auto,
                      ),
                    )),
                    Expanded(
                        child: Container(
                            // decoration: BoxDecoration(
                            //     color: Colors.white30,
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(10.0))),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.33,
                            padding: EdgeInsets.all(20.0),
                            margin: EdgeInsets.only(
                                top: 0, left: 20, right: 20, bottom: 40),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Blur radius:',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Slider(
                                        min: 10,
                                        max: 70,
                                        value: _blurRadius,
                                        onChanged: (value) {
                                          setState(() {
                                            _blurRadius = value;
                                          });
                                        }),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                      checkColor: Colors.purple,
                                      value: _auto,
                                      onChanged: (value) {
                                        setState(() {
                                          _auto = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Automatic glowing enabled',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            )))
                  ],
                ))
          ],
        ));
  }
}
