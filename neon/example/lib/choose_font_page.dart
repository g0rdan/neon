import 'package:flutter/material.dart';
import 'package:neon/neon.dart';

import 'ui_helper.dart';
import 'wall_bg.dart';

class ChooseFontPage extends StatefulWidget {
  ChooseFontPage({Key? key}) : super(key: key);

  @override
  _ChooseFontPageState createState() => _ChooseFontPageState();
}

class _ChooseFontPageState extends State<ChooseFontPage> {
  NeonFont _neonFont = NeonFont.Membra;
  double _fontSize = 30;
  MaterialColor _color = Colors.deepPurple;
  String _colorName = 'deepPurple';
  TextEditingController _textEditingController =
      TextEditingController(text: 'Cyberpunk');

  List<MapEntry<String, MaterialColor>> _colors = [];

  @override
  void initState() {
    _initColorList();
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
                        text: _textEditingController.text,
                        color: _color,
                        fontSize: _fontSize,
                        font: _neonFont,
                        blurRadius: 10,
                      ),
                    )),
                    Expanded(
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              children: <Widget>[
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
                                    labelText: 'Text',
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Font size:',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Slider(
                                          min: 10,
                                          max: 70,
                                          value: _fontSize,
                                          onChanged: (value) {
                                            setState(() {
                                              _fontSize = value;
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                    child: Text(
                                        _neonFont.toString().split('.')[1]),
                                    onPressed: () {
                                      UIHelper.generateModalBottomSheet<
                                              NeonFont>(
                                          context, NeonFont.values,
                                          onChangedCallback: (value) {
                                        _neonFont = value;
                                      }, onPressCallback: () {
                                        setState(() {});
                                        Navigator.of(context).pop();
                                      }, actionIcon: Icons.check);
                                    }),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              _color),
                                    ),
                                    child: Text(_colorName),
                                    onPressed: () {
                                      UIHelper.generateModalBottomSheet<
                                              MapEntry<String, MaterialColor>>(
                                          context, _colors,
                                          onChangedCallback: (value) {
                                        _color = value.value;
                                        _colorName = value.key;
                                      }, onPressCallback: () {
                                        setState(() {});
                                        Navigator.of(context).pop();
                                      }, actionIcon: Icons.check);
                                    })
                              ],
                            )))
                  ],
                ))
          ],
        ));
  }

  void _initColorList() {
    _colors.add(MapEntry<String, MaterialColor>('amber', Colors.amber));
    _colors.add(MapEntry<String, MaterialColor>('blue', Colors.blue));
    _colors.add(MapEntry<String, MaterialColor>('brown', Colors.brown));
    _colors.add(MapEntry<String, MaterialColor>('cyan', Colors.cyan));
    _colors
        .add(MapEntry<String, MaterialColor>('deepOrange', Colors.deepOrange));
    _colors.add(MapEntry<String, MaterialColor>('green', Colors.green));
    _colors.add(MapEntry<String, MaterialColor>('indigo', Colors.indigo));
    _colors.add(MapEntry<String, MaterialColor>('lightBlue', Colors.lightBlue));
    _colors.add(MapEntry<String, MaterialColor>('lime', Colors.lime));
    _colors.add(MapEntry<String, MaterialColor>('orange', Colors.orange));
    _colors.add(MapEntry<String, MaterialColor>('pink', Colors.pink));
    _colors.add(MapEntry<String, MaterialColor>('purple', Colors.purple));
    _colors.add(MapEntry<String, MaterialColor>('red', Colors.red));
    _colors.add(MapEntry<String, MaterialColor>('yellow', Colors.yellow));
  }
}
