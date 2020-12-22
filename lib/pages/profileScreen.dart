import 'package:event/database/userDB.dart';
import 'package:event/model/user.dart';
import 'package:event/widgets/ProfilePageDetails.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  User user = UserDB.getUser();

  @override
  Widget build(BuildContext context) {
    final double boxHeight = MediaQuery.of(context).size.height / 100;
    final double boxWidth = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: Stack(children: [
        Container(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 16,
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.black54]),
              image: DecorationImage(
                  image: UserDB.getUser().avtar == null
                      ? AssetImage("assets/profile.jpg")
                      : NetworkImage(user.avtar),
                  fit: BoxFit.cover)),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: boxWidth * 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black54, Colors.black54]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                shape: CircleBorder(),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: UserDB.getUser().avtar == null
                        ? AssetImage("assets/profile.jpg")
                        : NetworkImage(user.avtar, scale: 1),
                  ),
                ),
              ),
              Container(
                // height: 800,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    PrrofilePageDetails(
                      details: {
                        "title": "Full Name",
                        "data": user.firstName + " " + user.lastName,
                        "icon": Icons.person
                      },
                    ),
                    PrrofilePageDetails(
                      details: {
                        "title": "Email",
                        "data": user.email,
                        "icon": Icons.mail
                      },
                    ),
                    PrrofilePageDetails(
                      details: {
                        "title": "Date of Birth",
                        "data": user.dob.toString().split(" ")[0],
                        "icon": Icons.cake
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
