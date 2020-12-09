import 'package:flutter/material.dart';
import 'package:github_flutter/common/style/gsy_style.dart';

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
    Widget widget = rightWidget;
    if (rightWidget == null) {
      widget = (needRightLocalIcon)
          ? IconButton(
              icon: Icon(
                iconData,
                key: rightKey,
                size: 19.0,
                color: GSYColors.white,
              ),
              onPressed: () {
                RenderBox renderBox2 =
                    rightKey.currentContext?.findRenderObject();
                final position = renderBox2.localToGlobal(Offset.zero);
                final size = renderBox2.size;
                final centerPosition = Offset(
                  position.dx + size.width / 2,
                  position.dy + size.height / 2,
                );
                onRightIconPressed.call(centerPosition);
              },
            )
          : Container();
    }
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
            child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
        widget
      ],
    ));
  }
}
