import 'package:event/model/club.dart';
import 'package:event/pages/editListPage.dart';
import 'package:flutter/material.dart';

class ClubListCard extends StatelessWidget {
  Club data;

  ClubListCard(Club club) {
    this.data = club;
  }
  static final String mode = "view";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(EditListPage.routeName, arguments: {"data":data.id,"mode" :mode });
      },
      child: Card(
        elevation: 10,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.width / 2) - 15,
              width: (MediaQuery.of(context).size.width / 2) - 15,
              child: Image(
                image: NetworkImage(data.poster),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width / 2) - 15,
              alignment: Alignment.bottomLeft,
              child: Text(data.name),
            )
          ],
        ),
      ),
    );
  }
}
