import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CreateEditPageSliverAppBarTitle extends SliverPersistentHeaderDelegate {
  String poster;

  CreateEditPageSliverAppBarTitle(String poster) {
    this.poster = poster;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: <Widget>[
        Container(
          child: CircleAvatar(
            backgroundImage: AssetImage(poster),
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        )
      ],
    );
  }

  @override
  double get maxExtent => 350;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
