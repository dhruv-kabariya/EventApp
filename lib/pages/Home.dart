import 'package:event/Bloc/ClubBloc/clubbloc_bloc.dart';
import 'package:event/Bloc/maincubit/main_cubit.dart';
import 'package:event/pages/eventList.dart';
import 'package:event/pages/historyEvents.dart';
import 'package:event/widgets/clubListView.dart';
import 'package:flutter/material.dart';

import 'package:event/univesal/AppBar.dart';
import 'package:event/univesal/Drawer.dart';
import 'package:event/univesal/NavigationBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  MainCubit bloc;
  ClubblocBloc clubBloc;

  @override
  void initState() {
    clubBloc = BlocProvider.of<ClubblocBloc>(context);
    clubBloc..add(FetchClubs());
    bloc = BlocProvider.of<MainCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        bottomNavigationBar: MyNavigationBar(),
        body: BlocBuilder(
          cubit: clubBloc,
          builder: (context, state) {
            if (state is ClubFetched) {
              return CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: MyAppBar(),
                    floating: true,
                  ),
                  BlocBuilder<MainCubit, MainState>(
                    cubit: bloc,
                    // ignore: missing_return
                    builder: (context, state) {
                      if (BlocProvider.of<ClubblocBloc>(context).state
                          is GettingClubs) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is HomeSelected) {
                        return EventlistView();
                      } else if (state is ClubSelected) {
                        return ClubListView();
                      } else if (state is HistorySelected) {
                        return HistoryEventListView();
                      }
                    },
                  ),
                ],
              );
              // (state is GettingClubs || state is ClubblocInitial)
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    clubBloc.close();
    super.dispose();
  }
}
