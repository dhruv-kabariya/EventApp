import 'package:flutter/material.dart';


class DetailPageDateTime extends StatelessWidget {
  const DetailPageDateTime({
    Key key,
    @required this.details,
  }) : super(key: key);

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.bottomLeft,
                    child: Text(details["Title"],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            fontSize: 16))),
                // Divider(height: 5,),
                Container(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          details["icon"],
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(details["data"],
                            style: TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                      ],
                    )),
              ],
            )));
  }
}
