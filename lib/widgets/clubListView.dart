import 'package:event/Bloc/ClubBloc/clubbloc_bloc.dart';
import 'package:event/database/clubDB.dart';
import 'package:event/model/club.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './ClubListCard.dart';

class ClubListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ClubblocBloc bloc = BlocProvider.of<ClubblocBloc>(context);

    return BlocBuilder<ClubblocBloc, ClubblocState>(
      cubit: bloc,
      // ignore: missing_return
      builder: (context, state) {
        if (state is ClubFetched) {
          List<Club> clubs = ClubDB.getclubList();

          return SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ClubListCard(clubs[index]);
              },
              childCount: clubs.length,
            ),
          );
        } else if (state is GettingClubs || state is ClubblocInitial) {
          return SliverFillRemaining(
            child: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
