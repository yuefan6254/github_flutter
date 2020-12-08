import 'package:flutter/material.dart';

/**
 * 支持顶部和底部的TabBar控件
 */

class GSYTabBarWidget extends StatefulWidget {
  final TabType type;
  final List<Widget> tabViews;
  final List<Widget> tabItems;

  GSYTabBarWidget(
      {Key key, this.type = TabType.top, this.tabViews, this.tabItems})
      : super(key: key);

  _GSYTabBarWidgetState createState() => _GSYTabBarWidgetState();
}

class _GSYTabBarWidgetState extends State<GSYTabBarWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabItems.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget build(BuildContext context) {
    // 顶部tab bar
    if (widget.type == TabType.top) {
      return Scaffold();
    }

    // 底部tab bar
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: widget.tabViews,
      ),
      bottomNavigationBar: Material(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.tabItems,
        ),
      ),
    );
  }
}

enum TabType { top, bottom }
