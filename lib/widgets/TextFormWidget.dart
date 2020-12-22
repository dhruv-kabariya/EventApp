import 'package:flutter/material.dart';

class MyTextFormFild extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isEmail;
  final bool isPassword;

  MyTextFormFild(
      {this.hintText,
      this.isEmail,
      this.isPassword,
      this.onSaved,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Text("data");
  }
}
