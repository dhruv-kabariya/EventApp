import 'package:flutter/material.dart';


class ShowImagePickOption extends StatelessWidget {
  Function camera;
  Function gallery;
  

  ShowImagePickOption({
    @required this.gallery,
    @required this.camera});

  @override
  Widget build(BuildContext context) {
    return Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.camera,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    camera();
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.image,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    gallery();
                                  })
                            ],
                          ));
  }
}