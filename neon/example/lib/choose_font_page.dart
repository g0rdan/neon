import 'package:example/ui_helper.dart';
import 'package:example/wall_bg.dart';
import 'package:flutter/material.dart';
import 'package:neon/neon.dart';

class ChooseFontPage extends StatefulWidget {
  ChooseFontPage({Key key}) : super(key: key);

  @override
  _ChooseFontPageState createState() => _ChooseFontPageState();
}

class _ChooseFontPageState extends State<ChooseFontPage> {
  NeonFont _neonFont = NeonFont.Membra;
  double _fontSize = 30;
  TextEditingController _textEditingController =
      TextEditingController(text: 'Cyberpunk');

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
                        color: Colors.deepPurple,
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
                                Slider(
                                    min: 10,
                                    max: 70,
                                    value: _fontSize,
                                    onChanged: (value) {
                                      setState(() {
                                        _fontSize = value;
                                      });
                                    }),
                                RaisedButton(
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
                                    })
                              ],
                            )))
                  ],
                ))
          ],
        ));
  }
}
