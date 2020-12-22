import 'package:flutter/material.dart';

class EventPreCreateBottom extends StatelessWidget {
  GlobalKey<FormState> _key;
  String _method;
  EventPreCreateBottom(GlobalKey<FormState> key, String method, Map map) {
    _key = key;
    _method = method;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: BottomAppBar(
        color: Color(0xFF353535),
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              elevation: 10,
              onPressed: () {
                if (_key.currentState.validate()) {
                  _key.currentState.save();
                  // Provider.of<CreateEditEvent>(context).callMethod(_method, Event());
                }
              },
              child: Text("Preview"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            RaisedButton(
              elevation: 10,
              onPressed: () {},
              child: Text("Save"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            )
          ],
        ),
      ),
    );
  }
}
