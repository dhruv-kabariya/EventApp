import 'package:event/model/event.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  Widget where;

  void pageRoute(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => where),
    );
  }

  Event details;

  EventCard(Event data, Widget where) {
    this.details = data;
    this.where = where;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pageRoute(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.transparent,
          elevation: 2,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xFF1E1E1E),
                  Colors.transparent,
                  Color(0xB31E1E1E),
                  Color(0xFF1E1E1E)
                ])),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 200,
                      decoration: BoxDecoration(
                          // color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(details.poster),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                Positioned(
                    child: Container(
                  margin: EdgeInsets.only(top: 14),
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [
                            Colors.black38,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black54
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                )),
                Positioned(
                  left: 15,
                  top: 170,
                  child: Container(
                    child: Text(
                      details.name,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 220,
                  child: Container(
                    height: 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 18,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              details.venue,
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xD9FFFFFF)),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.av_timer,
                              size: 18,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              details.date.hour.toString() +
                                  " : " +
                                  details.date.minute.toString(),
                              style: TextStyle(
                                  fontSize: 14,

                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(details.club.poster),
                    radius: 25,
                    child: Card(
                      elevation: 5,
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 10,
                    child: Card(
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              details.date.day.toString(),
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              details.date.month.toString(),
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black45),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
