import 'dart:io';
import 'dart:async';
import 'package:event/database/userDB.dart';
import 'package:event/model/user.dart';
import 'package:event/widgets/DatePicker.dart';
import 'package:event/widgets/selectImageFunction.dart';
import 'package:event/widgets/showImgaePickOption.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _image;
  String _dob;
  User user;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  String firstName;

  final TextEditingController _lastNameController = TextEditingController();
  String lastName;

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

  Future _selectDOB() async {
    DateTime selectedDate = await selectDate(
        context: context, startTime: DateTime(2019), endTime: DateTime(2021));

    if (selectedDate != null) {
      setState(() {
        _dob = selectedDate.toString().split(" ")[0];
      });
    }
  }

  @override
  void initState() {
    user = UserDB.getUser();
    firstName = user.firstName;
    lastName = user.lastName;
    _dob = user.dob.toString().split(" ")[0];

    _firstNameController.text = firstName;
    _lastNameController.text = lastName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 100,
            left: (MediaQuery.of(context).size.width) / 2 - 70,
            child: Card(
              shape: CircleBorder(),
              elevation: 10,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: _image == null
                    ? NetworkImage(user.avtar)
                    : FileImage(_image),
              ),
            ),
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width) / 2 + 40,
            top: (190),
            child: IconButton(
              icon: Icon(
                Icons.add_a_photo,
                size: 36,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ShowImagePickOption(
                        gallery: _pickImageFromGallary,
                        camera: _pickImageFromCamera,
                      );
                    });
              },
            ),
          ),
          Positioned(
              left: 10,
              top: 330,
              child: Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: (MediaQuery.of(context).size.width) / 2 - 25,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _firstNameController,
                                  // autofocus: true,
                                  autocorrect: false,
                                  decoration:
                                      InputDecoration(labelText: "First Name"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            width: (MediaQuery.of(context).size.width) / 2 - 25,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _lastNameController,
                                  // autofocus: true,
                                  autocorrect: false,
                                  decoration:
                                      InputDecoration(labelText: "Last Name"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white38),
                            ),
                            // Divider(),
                            Text(user.email)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Date Of Birth",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white38)),
                            SizedBox(
                              height: 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectDOB();
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.cake),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(_dob),
                                  Container(
                                      padding: EdgeInsets.only(left: 170),
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          icon: Icon(Icons.mode_edit),
                                          onPressed: () {
                                            _selectDOB();
                                          }))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
