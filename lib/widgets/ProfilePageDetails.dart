import 'package:flutter/material.dart';

class PrrofilePageDetails extends StatelessWidget {

  
  const PrrofilePageDetails({
    @required this.details,
    Key key,
  }) : super(key: key);
final Map<String,dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(details["title"],style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w400,fontSize: 14),),
          Divider(height: 10,thickness: 1,endIndent: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(details["icon"]),
              SizedBox(width: 5,),
              Text(details["data"],style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500,fontSize: 16),),
            ],
          ),
        ],
      ),
    );
  }
}