import 'package:flutter/material.dart';

class ClubListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      
      delegate: SliverChildBuilderDelegate(
        (context,index) {
          return Container(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top:0,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 10,
                      child: Container(
                        child: Image(image: AssetImage("dhruv.jpg"),fit: BoxFit.fill,),
                        width: MediaQuery.of(context).size.width - 16,
                        height: 200,
                      ),
                  )),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent,Colors.black54],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)
                      ),
                    )),
                  Positioned(
                    top: 120,
                    left: 20,
                    child: Card(
                      elevation: 10,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("music.png"),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 90,
                      top: 130,
                        child: Container(
                        padding: EdgeInsets.all(10),
                        height: 90,
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width,
                        child: Text("Music CLub"),
                      ),
                    )
                ],
              ),
            ),
          );
        },
        childCount: 2,

      ),
    );
  }
}