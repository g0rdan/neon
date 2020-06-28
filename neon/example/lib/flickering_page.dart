import 'package:example/wall_bg.dart';
import 'package:flutter/material.dart';
import 'package:neon/neon.dart';

class FlickeringPage extends StatefulWidget {
  FlickeringPage({Key key}) : super(key: key);

  @override
  _FlickeringPageState createState() => _FlickeringPageState();
}

class _FlickeringPageState extends State<FlickeringPage> {
  bool _auto = true;
  List<int> _indexes = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _textEditingController.addListener(() {
      var text = _textEditingController.text;
      text.split(',').forEach((char) {
        var index = int.parse(char);
        if (index != null) {
          setState(() {
            _indexes.add(index);
          });
        }
      });
    });
    super.initState();
  }

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
                        text: 'Retro',
                        color: Colors.green,
                        fontSize: 50,
                        font: NeonFont.Membra,
                        flickeringText: _auto,
                        flickeringLetters: _indexes,
                      ),
                    )),
                    Expanded(
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              children: <Widget>[
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
                                      'Automatic flickering enabled',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                TextField(
                                  controller: _textEditingController,
                                  style: TextStyle(color: Colors.white),
                                  onChanged: (value) {
                                    setState(() {
                                      _textEditingController.text = value;
                                    });
                                  },
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                    // hin: Colors.deepPurple,
                                    border: OutlineInputBorder(),
                                    labelText:
                                        'Input letter\'s indexes of the word',
                                  ),
                                ),
                              ],
                            )))
                  ],
                ))
          ],
        ));
  }
}
