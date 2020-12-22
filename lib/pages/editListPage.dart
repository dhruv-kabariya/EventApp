import 'package:event/database/clubDB.dart';
import 'package:event/database/eventDB.dart';
import 'package:event/model/club.dart';
import 'package:event/model/event.dart';

import 'package:event/pages/EventDetailScreen.dart';
import 'package:event/pages/editEventPage.dart';
import 'package:event/widgets/EventListCard.dart';
import 'package:flutter/material.dart';

class EditListPage extends StatelessWidget {
  static String routeName = "clubEventList/";

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    print(data);
    Club club = ClubDB.getClub(data["data"]);
    List<Event> clubEventList =
        EventDB.getClubEvent(data["data"]); //Events.clubEvent(data["data"]);
    print(clubEventList);
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 3,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(club.name),
              background: Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(club.poster), fit: BoxFit.cover),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.black26,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black38
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                )
              ]),
            ),
            floating: true,
            pinned: true,
            expandedHeight: 200,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return EventCard(
                clubEventList[index],
                data["mode"] == "view"
                    ? DeatilScreenPage(clubEventList[index])
                    : EditEventPage(clubEventList[index]));
          }, childCount: clubEventList.length))
        ],
      ),
    ));
  }
}
