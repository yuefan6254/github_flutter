import 'package:flutter/material.dart';

/**
 * 输入框
 */

class GSYInputWidget extends StatefulWidget {
  final String hitText;
  final IconData iconData;
  final TextEditingController controller;
  final TextStyle textStyle;
  final ValueChanged<String> onChanged;
  final bool obscureText;

  GSYInputWidget(
      {Key key,
      this.hitText,
      this.iconData,
      this.controller,
      this.textStyle,
      this.onChanged,
      this.obscureText = false})
      : super(key: key);

  @override
  _GSYInputWidgetState createState() => _GSYInputWidgetState();
}

class _GSYInputWidgetState extends State<GSYInputWidget> {
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          hintText: widget.hitText,
          hintStyle: widget.textStyle,
          icon: widget.iconData == null ? null : Icon(widget.iconData)),
    );
  }
}
