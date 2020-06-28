import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIHelper {
  static void generateModalBottomSheet<T>(BuildContext context, List<T> options,
      {@required Function(T) onChangedCallback,
      @required Function onPressCallback,
      double height = 180,
      IconData actionIcon = Icons.close}) {
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
                        return new Center(
                          child: new Text(
                            '${options[index]}',
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
}
