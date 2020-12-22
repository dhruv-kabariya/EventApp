import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyDetailPageImage extends SliverPersistentHeaderDelegate {
  String poster;
  String name;

  MyDetailPageImage(String poster, String name) {
    this.name = name;
    this.poster = poster;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Container(
          height: 450,
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            poster,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
            left: 15,
            top: 10,
            child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                })),
        Positioned(
            right: 15,
            top: 10,
            child: IconButton(icon: Icon(Icons.share), onPressed: () {})),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white,
            ),
          ),
        ),
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
