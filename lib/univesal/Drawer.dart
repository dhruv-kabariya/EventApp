import 'package:event/Bloc/AuthenticationBloc/authenticationbloc_bloc.dart';
import 'package:event/Bloc/Theme/theme_cubit.dart';
import 'package:event/database/userDB.dart';
import 'package:event/model/club.dart';
import 'package:event/model/user.dart';
import 'package:event/pages/createEnvent.dart';
import 'package:event/pages/editListPage.dart';
import 'package:event/pages/profileScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  User user = UserDB.getUser();
  Club club = UserDB.getClub();

  @override
  Widget build(BuildContext context) {
    double boxHeight = MediaQuery.of(context).size.height / 100;
    double boxWidth = MediaQuery.of(context).size.width / 100;

    return Drawer(
      elevation: 10,
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage()));
            },
            child: ClipPath(
              clipper: MyUpperHalfCiecle(),
              child: Container(
                color: Color(0xB3FFC68A),
                height: boxHeight * 30,
                // width: boxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      child: Card(
                        elevation: 20,
                      ),
                      radius: 55,
                      backgroundImage: user.avtar == null
                          ? AssetImage("assets/profile.jpg")
                          : NetworkImage(UserDB.getUser().avtar),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      user.firstName + " " + user.lastName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Member Setting",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  endIndent: 10,
                ),
                ListTile(
                  title: Text("Create Event"),
                  enabled: user.memberShip,
                  onTap: user.memberShip
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreateEventPage(),
                            ),
                          );
                        }
                      : null,
                ),
                ListTile(
                  title: Text("Edit Event"),
                  enabled: user.memberShip,
                  onTap: user.memberShip
                      ? () {
                          Navigator.of(context).pushNamed(
                              EditListPage.routeName,
                              arguments: {"data": club.id, "mode": "edit"});
                        }
                      : null,
                ),
                ListTile(
                  title: Text("Scan QR"),
                  enabled: user.memberShip,
                  onTap: user.memberShip
                      ? null
                      // () {
                      //     Navigator.of(context).pushNamed(
                      //         EditListPage.routeName,
                      //         arguments: club.id);
                      //   }
                      : null,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Setting",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Divider(
                  thickness: 1,
                  endIndent: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Dark Mode",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      Switch(
                          value: BlocProvider.of<ThemeCubit>(context).state
                                  is DarkMode
                              ? true
                              : false,
                          onChanged: (value) {
                            BlocProvider.of<ThemeCubit>(context).changeTheme();
                          }),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    "About Us",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                ListTile(
                  onTap: () {
                    BlocProvider.of<AuthenticationblocBloc>(context)
                        .add(AuthenticationLogout());
                  },
                  trailing: Icon(Icons.arrow_forward),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyUpperHalfCiecle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    // path.lineTo(x, y)
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
