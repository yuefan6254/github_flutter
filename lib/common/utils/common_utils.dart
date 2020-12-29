import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/redux/locale_redux.dart';
import 'package:github_flutter/redux/theme_redux.dart';
import 'package:github_flutter/widgets/gsy_flex_button.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/common/localization/localizations.dart';
import 'package:github_flutter/common/utils/navigator_utils.dart';
import 'package:github_flutter/redux/gsy_state.dart';
import 'package:github_flutter/common/config/config.dart';

/**
 * 通用逻辑
 */

class CommonUtils {
  static Locale curLocale;

  static getThemeDtata(Color color) {
    return ThemeData(primaryColor: color, platform: TargetPlatform.android);
  }

  // 切换语言
  static changeLocale(Store<GSYState> store, int index) {
    Locale locale = store.state.platformLocale;

    if (Config.DEBUG) {
      print(store.state.platformLocale);
    }

    switch (index) {
      case 1:
        locale = Locale('zh', 'CN');
        break;
      case 2:
        locale = Locale('en', 'US');
        break;
    }

    store.dispatch(RefreshLocaleAction(locale));
  }

  // 切换语言弹框
  static showLanguageDialog(BuildContext context) {
    List<String> list = [
      GSYLocalizations.i18n(context).home_language_default,
      GSYLocalizations.i18n(context).home_language_zh,
      GSYLocalizations.i18n(context).home_language_en,
    ];

    showCommitOptionDialog(context, list, (index) {
      changeLocale(StoreProvider.of<GSYState>(context), index);
    }, height: 150.0);
  }

  // 列表选项 弹框
  static Future<Null> showCommitOptionDialog(
    BuildContext context,
    List<String> commitMaps,
    ValueChanged<int> onTap, {
    width = 250.0,
    height: 400.0,
    List<Color> colorList,
  }) {
    return NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
                width: width,
                height: height,
                padding: EdgeInsets.all(4.0),
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: GSYColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
                child: ListView.builder(
                    itemCount: commitMaps.length,
                    itemBuilder: (context, index) {
                      return GSYFlexButton(
                        text: commitMaps[index],
                        color: colorList != null
                            ? colorList[index]
                            : Theme.of(context).primaryColor,
                        textColor: GSYColors.white,
                        maxLines: 1,
                        mainAixsAlignment: MainAxisAlignment.start,
                        onPress: () => onTap(index),
                      );
                    })),
          );
        });
  }

  // loading 弹框
  static Future<Null> showLoadingDialog(BuildContext context) {
    return NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            child: WillPopScope(
              onWillPop: () => Future.value(false),
              child: Center(
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  child: Column(
                    children: [
                      SpinKitFadingCircle(
                        color: Colors.white,
                      ),
                      Container(height: 10.0),
                      Text(
                        GSYLocalizations.i18n(context).loading_text,
                        style: GSYConstant.normalTextWhite,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  // 返回主题颜色列表
  static List<Color> getThemeListColor() {
    return [
      GSYColors.primarySwatch,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange
    ];
  }

  // 获取主题
  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color, platform: TargetPlatform.android);
  }

  // 更新store中的颜色主题
  static pushTheme(Store store, int index) {
    ThemeData themeData;
    List<Color> colors = getThemeListColor();
    themeData = getThemeData(colors[index]);

    if (themeData != null) {
      store.dispatch(RefreshThemeDataAction(themeData));
    }
  }
}
