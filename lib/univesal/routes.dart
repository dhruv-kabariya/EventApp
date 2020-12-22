
import 'package:event/pages/AboutUs.dart';
import 'package:event/pages/Home.dart';
import 'package:event/pages/createEnvent.dart';
import 'package:event/pages/editListPage.dart';
import 'package:event/pages/eventList.dart';
import 'package:event/pages/login.dart';
import 'package:event/pages/profileScreen.dart';
import 'package:event/pages/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:event/main.dart';
Map<String,WidgetBuilder> routes = {
        "/login":(context) => LoginPage(),
        "/signup":(context) => SignUpPage(),
        "/home":(context) => MyHome(),
        "/profile":(context) => ProfilePage(),
        "/creteEvent":(context) => CreateEventPage(),
        "/editEvent":(context) => EditListPage(),
        "/aboutUs":(context) => AboutUs(),
        "/eventList" : (context) => EventlistView(),
        EditListPage.routeName : (context) => EditListPage(),
        LandingPage.routeName :(context) => LandingPage()        
        
      };