import 'package:flutter/material.dart';

/**
 * button-充满
 */

class GSYFlexButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPress;
  final double fontSize;
  final int maxLines;
  final MainAxisAlignment mainAixsAlignment;

  GSYFlexButton(
      {Key key,
      this.text,
      this.color,
      this.textColor,
      this.onPress,
      this.fontSize = 20.0,
      this.maxLines = 1,
      this.mainAixsAlignment = MainAxisAlignment.center})
      : super(key: key);

  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPress,
      color: color,
      textColor: textColor,
      padding:
          EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
      child: Flex(
        mainAxisAlignment: mainAixsAlignment,
        direction: Axis.horizontal,
        children: [
          Expanded(
              child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
            textAlign: TextAlign.center,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      ),
    );
  }
}
