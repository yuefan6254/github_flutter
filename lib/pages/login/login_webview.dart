import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:github_flutter/common/localization/localizations.dart';
import 'package:github_flutter/common/style/gsy_style.dart';

/**
 * login webview
 */

class LoginWebView extends StatefulWidget {
  final String url;
  final String title;

  LoginWebView(this.url, this.title);

  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  final FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        if (state.type == WebViewState.shouldStart) {
          if (state.url != null &&
              state.url.startsWith("gsygithubapp://authed")) {
            var code = Uri.parse(state.url).queryParameters["code"];
            flutterWebviewPlugin.reloadUrl("about:blank");
            Navigator.of(context).pop(code);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  _renderTitle() {
    if (widget.url == null || widget.url.length == 0) {
      return Text(widget.title);
    }

    return Row(
      children: [
        Expanded(
            child: Container(
          child: Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ))
      ],
    );
  }

  renderLoading() {
    return Center(
      child: Container(
        width: 200.0,
        height: 200.0,
        padding: EdgeInsets.all(4.0),
        child: Row(
          children: [
            SpinKitDoubleBounce(color: Theme.of(context).primaryColor),
            Container(width: 10.0),
            Container(
              child: Text(
                GSYLocalizations.i18n(context).loading_text,
                style: GSYConstant.middleText,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebviewScaffold(
            appBar: AppBar(
              title: _renderTitle(),
            ),
            initialChild: renderLoading(),
            url: widget.url,
          )
        ],
      ),
    );
  }
}
