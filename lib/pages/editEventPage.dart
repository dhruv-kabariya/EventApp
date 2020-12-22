import 'dart:convert';
import 'dart:io';

import 'package:event/Bloc/EventCE/eventce_cubit.dart';
import 'package:event/database/userDB.dart';
import 'package:event/model/event.dart';

import 'package:event/widgets/DatePicker.dart';
import 'package:event/widgets/selectImageFunction.dart';
import 'package:event/widgets/showImgaePickOption.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditEventPage extends StatefulWidget {
  Event event;
  EditEventPage(Event event) {
    this.event = event;
  }

  @override
  _EditEventPagePageState createState() => _EditEventPagePageState();
}

class _EditEventPagePageState extends State<EditEventPage> {
  EventceCubit bloc;
  String _description;
  String _name;
  String _link;
  String _venue;
  DateTime _date;
  String _time;
  String _spokePerson;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _decriptionController = TextEditingController();
  TextEditingController _linkController = TextEditingController();
  TextEditingController _venueController = TextEditingController();
  TextEditingController _spokeController = TextEditingController();

  File _image;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _pickImageFromGallary() async {
    File image = await pickImageFromGallery(100);
    setState(() {
      _image = image;
    });
  }

  _pickImageFromCamera() async {
    File image = await pickImageFromCamera(100);

    setState(() {
      _image = image;
    });
  }

  Future _selectDate() async {
    DateTime selectedDate = await selectDate(
        context: context, startTime: DateTime.now(), endTime: DateTime(2021));

    if (selectedDate != null) {
      setState(() {
        _date = selectedDate;
      });
    }
  }

  Future _selectTime() async {
    TimeOfDay time =
        await timeSelect(context: context, startTime: TimeOfDay.now());

    setState(() {
      _date.add(Duration(hours: time.hour, minutes: time.minute));
      _time = time.hour.toString() + ":" + time.minute.toString();
    });
  }

  @override
  void initState() {
    bloc = EventceCubit();

    _date = widget.event.date;

    _time = widget.event.date.hour.toString() +
        " : " +
        widget.event.date.minute.toString();

    _decriptionController.text = widget.event.decsription;
    _venueController.text = widget.event.venue;
    _nameController.text = widget.event.name;
    _linkController.text = widget.event.link;
    _spokeController.text = widget.event.spokePerson;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener(
        cubit: bloc,
        listener: (context, state) {
          if (state is UpdatedEvent) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }

          if (state is UpdatingEvent) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Updating Event"),
                content: Container(
                  padding: const EdgeInsets.all(10),
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          bottomNavigationBar: Container(
            height: 60,
            child: BottomAppBar(
              color: Color(0xFF353535),
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    elevation: 10,
                    onPressed: () {
                      Map<String, dynamic> data = {};

                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        data["id"] = widget.event.id;
                        data["name"] = _name;
                        data["club"] = {"id": UserDB.getClub().id};
                        data["timeDate"] = _date.toUtc().toString();
                        data["venue"] = _venue;
                        data["formLink"] = _link;
                        data["Description"] = _description;
                        data["SpokePerson"] = _spokePerson;
                        if (_image != null) {
                          data["poster"] =
                              base64Encode(_image.readAsBytesSync());
                        }
                        bloc.update(data);
                      }
                    },
                    child: Text("Save"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
            ),
          ),
          body: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ShowImagePickOption(
                            gallery: _pickImageFromGallary,
                            camera: _pickImageFromCamera);
                      });
                },
                child: Stack(
                  children: [
                    Container(
                      height: 450,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: _image == null
                                ? NetworkImage(widget.event.poster)
                                : FileImage(_image),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black54],
                          stops: [0.5, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          tileMode: TileMode.repeated,
                        ),
                      ),
                    ),
                    Positioned(
                        left: 15,
                        top: 10,
                        child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })),
                    Positioned(
                        right: 15,
                        top: 10,
                        child: IconButton(
                            icon: Icon(Icons.share), onPressed: () {})),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text("Event Name",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ),
                        Container(
                            child: Container(
                          width: 200,
                          child: TextFormField(
                            controller: _nameController,
                            autofocus: false,
                            validator: (value) {
                              if (value.length > 0) {
                                return null;
                              }
                              return "Enter Name of Event";
                            },
                            onSaved: (value) {
                              _name = value;
                            },
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Event name"),
                          ),
                        ))
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "Date",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _selectDate();
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.today,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              _date.day.toString() +
                                                  "-" +
                                                  _date.month.toString(),
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                        ],
                                      )),
                                ),
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(bottom: 5),
                                    alignment: Alignment.bottomLeft,
                                    child: Text("Time",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16))),
                                GestureDetector(
                                  onTap: () {
                                    _selectTime();
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.av_timer,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(_time,
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                        ],
                                      )),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                          child: Text("Venue",
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
                              Icon(
                                Icons.location_on,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 200,
                                child: TextFormField(
                                  controller: _venueController,
                                  autofocus: false,
                                  onSaved: (value) {
                                    _venue = value;
                                  },
                                  validator: (value) {
                                    if (value.length > 0) {
                                      return null;
                                    }
                                    return "Enter venue";
                                  },
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Place"),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                          child: Text("Spoke Person",
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
                              Icon(
                                Icons.person,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 200,
                                child: TextFormField(
                                  controller: _spokeController,
                                  autofocus: false,
                                  onSaved: (value) {
                                    _spokePerson = value;
                                  },
                                  validator: (value) {
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Spoke Person"),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Description"),
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                          color: Color(0xB3ffc68a),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                                validator: (value) {
                                  if (value.length > 0) {
                                    return null;
                                  }
                                  return "Enter Description";
                                },
                                onSaved: (value) {
                                  _description = value;
                                },
                                controller: _decriptionController,
                                // autofocus: true,
                                maxLines: 20,
                                minLines: 10,
                                maxLength: 600,
                                // expands: true,
                                decoration: InputDecoration(
                                    hintText: "Type Discription",
                                    border: InputBorder.none),
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14))),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 1,
                          color: Color(0xB3ffc68a),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                          child: Text("Form Link",
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
                              Container(
                                width: 200,
                                child: TextFormField(
                                  controller: _linkController,
                                  onSaved: (value) {
                                    _link = value;
                                  },
                                  validator: (value) {
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Form link",
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
