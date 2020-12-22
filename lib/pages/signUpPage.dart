import 'dart:convert';
import 'dart:io';

import 'package:event/Bloc/AuthenticationBloc/authenticationbloc_bloc.dart';
import 'package:event/Bloc/SignUpBloc/signup_bloc.dart';
import 'package:event/services/userService.dart';
import 'package:event/utils/validator.dart';
import 'package:event/widgets/selectImageFunction.dart';
import 'package:event/widgets/showImgaePickOption.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  final String routeName = "/signup";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignupBloc bloc;
  File _image;
  final _formKey = GlobalKey<FormState>();

  TextEditingController email;
  TextEditingController fn;
  TextEditingController ln;
  TextEditingController _conPassword;
  TextEditingController _password;

  _pickImageFromGallary() async {
    File image = await pickImageFromGallery(10);
    setState(() {
      _image = image;
    });
  }

  _pickImageFromCamera() async {
    File image = await pickImageFromCamera(10);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    email = TextEditingController();
    fn = TextEditingController();
    ln = TextEditingController();
    _conPassword = TextEditingController();
    _password = TextEditingController();

    bloc = SignupBloc(
      bloc: BlocProvider.of<AuthenticationblocBloc>(context),
      service: UserService(),
    );
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocListener<SignupBloc, SignupState>(
          cubit: bloc,
          listener: (context, state) {
            if (state.isFaild) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Error",
                    style: TextStyle(color: Colors.black),
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: BlocBuilder<SignupBloc, SignupState>(
            cubit: bloc,
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ShowImagePickOption(
                                  gallery: _pickImageFromGallary,
                                  camera: _pickImageFromCamera);
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _image == null
                                ? AssetImage("assets/user.png")
                                : FileImage(
                                    _image,
                                  ),
                          ),
                        ),
                        margin: EdgeInsets.only(top: 50),
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    30,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  controller: fn,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // hintStyle: TextStyle(),
                                    hintText: "First Name",
                                    contentPadding: EdgeInsets.only(
                                        left: 10, top: 2.5, bottom: 2.5),
                                    filled: true,
                                  ),
                                  validator: (String text) {
                                    if (text.length < 3) {
                                      return "Enter First Name";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    30,
                                margin: EdgeInsets.only(
                                  bottom: 10,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  controller: ln,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(),
                                    hintText: "Last Name",
                                    contentPadding: EdgeInsets.only(
                                        left: 10, top: 2.5, bottom: 2.5),
                                    filled: true,
                                  ),
                                  validator: (String text) {
                                    if (text.length < 5) {
                                      return "Enter Last Name";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              controller: email,
                              autofocus: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(),
                                hintText: "Email",
                                contentPadding: EdgeInsets.only(
                                    left: 20, top: 2.5, bottom: 2.5),
                                filled: true,
                              ),
                              onChanged: (String pass) {
                                bloc.add(SignupEmailChange(email: pass));
                              },
                              validator: (String text) {
                                if (!state.isSubmitting) {
                                  if (Validators.isValidEmail(text)) {
                                    return null;
                                  } else {
                                    return "Enter Valid Email";
                                  }
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              controller: _password,
                              autofocus: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(),
                                hintText: "Password",
                                contentPadding: EdgeInsets.only(
                                    left: 20, top: 2.5, bottom: 2.5),
                                filled: true,
                              ),
                              obscureText: true,
                              onChanged: (String pass) {
                                bloc.add(SignupPasswordChange(
                                    password: _password.text));
                              },
                              validator: (String text) {
                                if (!state.isSubmitting) {
                                  if (Validators.isValidPassword(text)) {
                                    return null;
                                  } else {
                                    return "Enter Valid Password";
                                  }
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              controller: _conPassword,
                              autofocus: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(),
                                hintText: "Confirm Password",
                                contentPadding: EdgeInsets.only(
                                    left: 20, top: 2.5, bottom: 2.5),
                                filled: true,
                              ),
                              obscureText: true,
                              onChanged: (String pass) {
                                bloc.add(SignupPasswordChange(password: pass));
                              },
                              validator: (String text) {
                                if (_conPassword.text != _password.text) {
                                  return "Enter Valid Password";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          RaisedButton(
                            elevation: 5,
                            onPressed: state.isSubmitting
                                ? null
                                : () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();

                                      bloc.add(
                                        SignupWithCredential(
                                          data: _image != null
                                              ? {
                                                  "username":
                                                      fn.text + "_" + ln.text,
                                                  "email": email.text,
                                                  "password": _password.text,
                                                  "avtar": base64Encode(
                                                      _image.readAsBytesSync()),
                                                  "first_name": fn.text,
                                                  "last_name": ln.text
                                                }
                                              : {
                                                  "username":
                                                      fn.text + "_" + ln.text,
                                                  "email": email.text,
                                                  "password": _password.text,
                                                  "first_name": fn.text,
                                                  "last_name": ln.text
                                                },
                                        ),
                                      );
                                    }
                                  },
                            disabledColor: Colors.blue[800],
                            color: Colors.blue[600],
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                              top:
                                  BorderSide(color: Colors.white, width: 0.5))),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<AuthenticationblocBloc>(context)
                              .add(AuthenticationLoginPage());
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Alredy have account! "),
                              Text(
                                "login",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
