import 'package:flutter/material.dart';

/**
 * 带icon图标的文本
 */

class GSYIconText extends StatelessWidget {
  final double padding;
  final IconData iconData;
  final String iconText;
  final Color iconColor;
  final TextStyle textStyle;
  final double iconSize;
  final VoidCallback onPressed;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  GSYIconText(
    this.iconData,
    this.iconText,
    this.textStyle,
    this.iconColor,
    this.iconSize, {
    this.padding = 0.0,
    this.onPressed,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
  });

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Icon(
            iconData,
            size: iconSize,
            color: iconColor,
          ),
          Padding(padding: EdgeInsets.all(padding)),
          Text(
            iconText,
            style: textStyle
                .merge(TextStyle(textBaseline: TextBaseline.alphabetic)),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
