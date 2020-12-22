import 'package:flutter/rendering.dart';

class DetailScreenCliper extends CustomClipper<Path>{
    
  

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(10, 20);
    return null;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    
    return true;
  }}