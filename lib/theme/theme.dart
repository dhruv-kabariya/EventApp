import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTheme with ChangeNotifier{
  
  bool themeMode = true;

  changeMode(bool what) async {
    
    this.themeMode = what;
    setPref(what);
    notifyListeners();
  }

  setPref(bool val) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool("theme", val);
  }

  mode(){

    return themeMode == true ? dark : light;
  }
  
  ThemeData dark = ThemeData(

    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Color(0xFF343434),
    // colorScheme: ColorScheme(primary: null, primaryVariant: null, secondary: null, secondaryVariant: null, surface: null, background: null, error: null, onPrimary: null, onSecondary: null, onSurface: null, onBackground: null, onError: null, brightness: null),
    
    cardColor: Color(0xFF353535),
    bottomAppBarColor: Color(0xFF262833),
    dividerColor: Color(0xFFFFC68A),
    
    fontFamily: 'Lato',
    textTheme: TextTheme(
      headline: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
      title: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
      body1: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500,fontSize: 16),
      body2: TextStyle(color: Colors.white70,fontWeight: FontWeight.w400,fontSize: 14),
      display1: TextStyle(color: Colors.white54,fontWeight: FontWeight.w300,fontSize: 18),
      subtitle: TextStyle(color: Colors.white30,fontWeight: FontWeight.w300,fontSize: 16),
      display2: TextStyle(color: Colors.white54,fontSize: 14,),
      caption: TextStyle(color: Colors.white24,fontWeight: FontWeight.w300,fontSize: 12),
      button: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),

    )
  );

  ThemeData light = ThemeData(
brightness: Brightness.light
  );
}