import 'package:event/Bloc/AuthenticationBloc/authenticationbloc_bloc.dart';
import 'package:event/Bloc/LoginBloc/loginbloc_bloc.dart';
import 'package:event/services/userService.dart';
import 'package:event/utils/validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final String routeName = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email;
  TextEditingController password;

  UserService service;
  LoginblocBloc bloc;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  void initState() {
    email = TextEditingController();

    password = TextEditingController();

    bloc = LoginblocBloc(
        loginService: UserService(),
        bloc: BlocProvider.of<AuthenticationblocBloc>(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double boxHeight = MediaQuery.of(context).size.height / 100;
    // final double boxWidth = MediaQuery.of(context).size.width / 100;

    return Scaffold(
        backgroundColor:
            Colors.black, //Theme.of(context).scaffoldBackgroundColor,
        body: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // logo of app
              Container(
                margin: EdgeInsets.only(top: 50),
                height: boxHeight * 10,
                width: boxHeight * 10,
                color: Colors.pink,
              ),
              Container(
                child: Column(
                  children: [
                    // credential feilds
                    BlocListener<LoginblocBloc, LoginblocState>(
                      cubit: bloc,
                      listener: (context, state) {
                        if (state.isFaild) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invalid Credentials"),
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<LoginblocBloc, LoginblocState>(
                        cubit: bloc,
                        builder: (context, state) {
                          return Container(
                            padding:
                                EdgeInsets.only(top: 8, left: 30, right: 30),
                            child: Column(
                              children: [
                                // email field
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
                                          left: 20, top: 5, bottom: 5),
                                      filled: true,
                                    ),
                                    onChanged: (String pass) {
                                      bloc.add(LoginEmailChange(email: pass));
                                    },
                                    validator: (String text) {
                                      if (text.length > 5) {
                                        if (text.contains("_")) {
                                          return null;
                                        } else {
                                          return "Enter Valid Email";
                                        }
                                      } else {
                                        return "Enter Email";
                                      }
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),

                                //  password fild
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: TextFormField(
                                    controller: password,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(),
                                      hintText: "Password",
                                      contentPadding: EdgeInsets.only(
                                          left: 20, top: 8, bottom: 8),
                                      filled: true,
                                    ),
                                    obscureText: true,
                                    onChanged: (String pass) {
                                      bloc.add(
                                          LoginPasswordChange(password: pass));
                                    },
                                    validator: (String text) {
                                      if (text.length > 5) {
                                        if (Validators.isValidPassword(text)) {
                                          return null;
                                        } else {
                                          return "Enter Valid Password";
                                        }
                                      } else {
                                        return "Enter Password";
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                ),

                                // login button
                                RaisedButton(
                                  elevation: 5,
                                  onPressed: state.isSubmitting
                                      ? null
                                      : () {
                                          print(key.currentState.validate());
                                          if (key.currentState.validate()) {
                                            bloc.add(LoginWithCredential(
                                                email: email.text,
                                                password: password.text));
                                          }
                                        },
                                  disabledColor: Colors.blue[800],
                                  color: Colors.blue[600],
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: state.isSubmitting
                                        ? CircularProgressIndicator()
                                        : Text(
                                            "Login",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // login with google button
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: 20,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset("google.png", fit: BoxFit.cover),
                          ),
                          Container(
                            child: Text(
                              "Sign In With Google",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.white, width: 0.5))),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<AuthenticationblocBloc>(context)
                        .add(AuthenticationSignUpPage());
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("don't have account? "),
                        Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
