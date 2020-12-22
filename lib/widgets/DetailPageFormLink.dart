import 'package:flutter/material.dart';

class DetailPageFormLink extends StatelessWidget {
  const DetailPageFormLink({
    Key key,
    @required this.details,
  }) : super(key: key);

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8),
            child: Text(details["Title"],
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(details["data"],
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
