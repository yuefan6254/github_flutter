import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/**
 * 动态头部
 */

class GSYSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Builder builder;
  final TickerProvider vSyncs;
  final bool changeSize;
  final FloatingHeaderSnapConfiguration snapConfig;
  AnimationController animationController;

  GSYSliverHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.snapConfig,
    @required this.vSyncs,
    this.child,
    this.builder,
    this.changeSize = false,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  TickerProvider get vsync => vSyncs;

  @override
  bool shouldRebuild(GSYSliverHeaderDelegate old) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => snapConfig;

  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (builder != null) {
      return builder(context, shrinkOffset, overlapsContent);
    }

    return child;
  }
}

typedef Widget Builder(
    BuildContext context, double shrinkOffset, bool overlapsContent);
