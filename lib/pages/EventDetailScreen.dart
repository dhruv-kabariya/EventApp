import 'package:event/model/event.dart';
import 'package:event/widgets/DetailPageDateTime.dart';
import 'package:event/widgets/DetailPageFormLink.dart';
import 'package:event/widgets/DetailPageUpperImage.dart';
import 'package:event/widgets/DetailPageVenue.dart';
import 'package:flutter/material.dart';
 
import 'package:event/univesal/DetailBottomAppBar.dart';

class DeatilScreenPage extends StatelessWidget {
  Event details;


  DeatilScreenPage(Event data) {
    this.details = data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: DetailBottomAppBar(details.id),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
                floating: true,
                delegate:
                    MyDetailPageImage(details.poster, details.name)),
            SliverToBoxAdapter(
              child: Column(children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      DetailPageDateTime(details: {
                        "Title": "Date",
                        "data": details.date.day.toString() +
                            "-" +
                            details.date.month.toString(),
                        "icon": Icons.today
                      }),
                      DetailPageDateTime(details: {
                        "Title": "Time",
                        "data": details.date.hour.toString() +
                            "-" +
                            details.date.minute.toString(),
                        "icon": Icons.av_timer
                      })
                    ],
                  ),
                ),
                DetailPageVenue(details: {
                  "Title": "Venue",
                  "data": details.venue,
                  "icon": Icons.location_on
                }),
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom :8.0,top: 8),
                        child: Text("Speaker",
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
                            Text(details.spokePerson,
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14)),
                          ],
                        ),
                      ),
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
                          child: Text(details.decsription,
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
                DetailPageFormLink(details: {
                  "Title" : "Form Link",
                  "data" : details.link 
                })
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

