import 'package:flutter/material.dart';

/**
 * 支持顶部和底部的TabBar控件
 */

class GSYTabBarWidget extends StatefulWidget {
  final TabType type;
  final List<Widget> tabViews;
  final List<Widget> tabItems;
  final Widget drawer;
  final Widget title;

  GSYTabBarWidget({
    Key key,
    this.type = TabType.top,
    this.tabViews,
    this.tabItems,
    this.drawer,
    this.title,
  }) : super(key: key);

  _GSYTabBarWidgetState createState() => _GSYTabBarWidgetState();
}

class _GSYTabBarWidgetState extends State<GSYTabBarWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

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
      return Scaffold(
        appBar: AppBar(
          title: widget.title,
          bottom: TabBar(
            tabs: widget.tabItems,
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: widget.tabViews,
        ),
      );
    }

    // 底部tab bar
    return Scaffold(
        drawer: widget.drawer,
        appBar: AppBar(
          title: widget.title,
        ),
        body: TabBarView(
          controller: _tabController,
          children: widget.tabViews,
        ),
        bottomNavigationBar: Material(
          color: Theme.of(context).primaryColor,
          child: SafeArea(
            child: TabBar(
              controller: _tabController,
              tabs: widget.tabItems,
            ),
          ),
        ));
  }
}

enum TabType { top, bottom }
