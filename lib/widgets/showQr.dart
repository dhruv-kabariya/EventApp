import 'package:event/database/userDB.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowQrImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: QrImage(
        data: UserDB.getUser().id.toString(),
        version: QrVersions.auto,
        embeddedImage: AssetImage("playstore.png"),
        embeddedImageStyle: QrEmbeddedImageStyle(size: Size(50, 50)),
        size: 300,
      ),
    );
  }
}
