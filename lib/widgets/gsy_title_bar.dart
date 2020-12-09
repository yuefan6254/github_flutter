import 'package:flutter/material.dart';

/**
 * title 控件
 */

class GSYTitleBar extends StatelessWidget {
  final String title;
  final IconData iconData;
  final ValueChanged onRightIconPressed;
  final bool needRightLocalIcon;
  final Widget rightWidget;
  final GlobalKey rightKey = GlobalKey();

  GSYTitleBar({
    this.title,
    this.iconData,
    this.onRightIconPressed,
    this.needRightLocalIcon = false,
    this.rightWidget,
  });

  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
            child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
      ],
    ));
  }
}
