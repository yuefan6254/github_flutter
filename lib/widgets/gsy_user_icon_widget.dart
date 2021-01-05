import 'package:flutter/material.dart';
import 'package:github_flutter/common/style/gsy_style.dart';

/**
 * 头像icon
 */

class GSYUserIconWidget extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  GSYUserIconWidget({
    this.image,
    this.onPressed,
    this.width = 30.0,
    this.height = 30.0,
    this.padding,
  });

  Widget build(BuildContext context) {
    return Container(
      child: RawMaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding ?? EdgeInsets.only(top: 4.0, right: 5.0, left: 5.0),
        constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: ClipOval(
          child: FadeInImage(
            placeholder: AssetImage(GSYICons.DEFAULT_USER_ICON),
            image: NetworkImage(image),
            fit: BoxFit.fitWidth,
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}
