import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event/model/club.dart';
import 'package:event/services/ClubService.dart';

import '../../database/clubDB.dart';
import 'package:meta/meta.dart';

part 'clubbloc_event.dart';
part 'clubbloc_state.dart';

class ClubblocBloc extends Bloc<ClubblocEvent, ClubblocState> {
  ClubblocBloc() : super(ClubblocInitial());

  ClubDB db = ClubDB();
  ClubServices servise = ClubServices();

  @override
  Stream<ClubblocState> mapEventToState(
    ClubblocEvent event,
  ) async* {
    if (event is FetchClubs) {
      yield* _mapFetchClubsToState();
    }
  }

  Stream<ClubblocState> _mapFetchClubsToState() async* {
    yield GettingClubs();
    List<Club> clubList = await servise.getClubList();
    print(clubList[0].poster);
    await db.addClubList(clubList);
    yield ClubFetched();
  }
}
