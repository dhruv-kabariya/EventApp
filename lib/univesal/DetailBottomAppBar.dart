import 'package:event/Bloc/OtherUser/otheruser_cubit.dart';
import 'package:event/model/otherUser.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBottomAppBar extends StatefulWidget {
  final int _eventId;
  DetailBottomAppBar(this._eventId);
  @override
  _DetailBottomAppBarState createState() => _DetailBottomAppBarState();
}

class _DetailBottomAppBarState extends State<DetailBottomAppBar> {
  OtheruserCubit bloc;
  @override
  void initState() {
    bloc = OtheruserCubit();
    bloc.getOtherUser(widget._eventId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: bloc,
      builder: (context, state) {
        if (state is FetchingOtherUser || state is OtheruserInitial) {
          return Container(
            height: 60,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is RegisteringUser) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is FetchedOtherUser) {
          return Container(
            height: 60,
            child: BottomAppBar(
              color: Color(0xFF353535),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: state.users.length > 0
                          ? GestureDetector(
                              onTap: () {
                                return showModalBottomSheet(
                                    context: context,
                                    elevation: 10,

                                    // backgroundColor: Colors.cyan,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(15),
                                          right: Radius.circular(15)),
                                    ),
                                    builder: (BuildContext context) {
                                      return RegisteredView(
                                        users: state.users,
                                      );
                                    });
                              },
                              child: state.users.length == 1
                                  ? Stack(
                                      children: <Widget>[
                                        Positioned(
                                            left: 20,
                                            bottom: 10,
                                            child: state.users[0].avtar == null
                                                ? Card(
                                                    shape: CircleBorder(),
                                                    child: CircleAvatar(
                                                      child: Center(
                                                        child: Text(state
                                                                .users[0]
                                                                .first_name[0] +
                                                            state.users[0]
                                                                .last_name[0]),
                                                      ),
                                                    ),
                                                  )
                                                : Card(
                                                    shape: CircleBorder(),
                                                    elevation: 10,
                                                    child: CircleAvatar(
                                                        radius: 15,
                                                        backgroundImage:
                                                            NetworkImage(state
                                                                .users[0]
                                                                .avtar)),
                                                  )),
                                      ],
                                    )
                                  : Stack(
                                      children: <Widget>[
                                        Positioned(
                                            left: 20,
                                            bottom: 10,
                                            child: Card(
                                              shape: CircleBorder(),
                                              elevation: 10,
                                              child: CircleAvatar(
                                                  radius: 15,
                                                  child: state.users[0].avtar ==
                                                          null
                                                      ? Text(state.users[0]
                                                              .first_name[0] +
                                                          state.users[0]
                                                              .last_name[0])
                                                      : Image.network(state
                                                          .users[0].avtar)),
                                            )),
                                        Positioned(
                                            left: 45,
                                            bottom: 10,
                                            child: Card(
                                              elevation: 10,
                                              shape: CircleBorder(),
                                              child: CircleAvatar(
                                                radius: 15,
                                                child: Text(
                                                    ((state.users.length) - 1)
                                                            .toString() +
                                                        "+"),
                                              ),
                                            )),
                                      ],
                                    ))
                          : Stack(children: <Widget>[
                              Positioned(
                                  left: 20,
                                  bottom: 10,
                                  child: Text("No have registered"))
                            ]),
                    ),
                    RaisedButton(
                      elevation: 10,
                      onPressed: state.containe
                          ? null
                          : () {
                              bloc.register(
                                  id: widget._eventId, userList: state.users);
                            },
                      child:
                          state.containe ? Text("You Are Going") : Text("Join"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class RegisteredView extends StatefulWidget {
  RegisteredView({
    this.users,
    Key key,
  }) : super(key: key);
  final List<OtherUser> users;
  @override
  _RegisteredViewState createState() => _RegisteredViewState();
}

class _RegisteredViewState extends State<RegisteredView> {
  @override
  Widget build(BuildContext context) {
    List<OtherUser> users = widget.users;

    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: users[index].avtar == null
                  ? Card(
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        child: Center(
                          child: Text(users[index].first_name[0] +
                              users[index].last_name[0]),
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(users[index].avtar),
                    ),
              title:
                  Text(users[index].first_name + " " + users[index].last_name));
        },
      ),
    );
  }
}
