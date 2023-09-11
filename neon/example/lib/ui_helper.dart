import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIHelper {
  static void generateModalBottomSheet<T>(
    BuildContext context,
    List<T> options, {
    required Function(T) onChangedCallback,
    required VoidCallback onPressCallback,
    double height = 180,
    IconData actionIcon = Icons.close,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
              height: height,
              child: Stack(
                children: <Widget>[
                  CupertinoPicker.builder(
                      squeeze: 1.5,
                      diameterRatio: 1,
                      useMagnifier: true,
                      scrollController: new FixedExtentScrollController(
                        initialItem: 0,
                      ),
                      itemExtent: 33.0,
                      backgroundColor: Colors.white,
                      onSelectedItemChanged: (int index) {
                        onChangedCallback(options[index]);
                      },
                      childCount: options.length,
                      itemBuilder: (context, index) {
                        var name = _getName(options[index]);
                        return new Center(
                          child: new Text(
                            name,
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }),
                  Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                          iconSize: 20,
                          icon: Icon(actionIcon),
                          onPressed: onPressCallback))
                ],
              ));
        });
  }

  static String _getName<T>(T t) {
    if (t is MapEntry) {
      return t.key.toString();
    }

    return t.toString();
  }
}
