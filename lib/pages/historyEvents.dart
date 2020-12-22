import 'package:event/Bloc/EventBloc/eventbloc_bloc.dart';
import 'package:event/pages/EventDetailScreen.dart';
import 'package:event/widgets/EventListCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryEventListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventblocBloc, EventblocState>(
      cubit: BlocProvider.of<EventblocBloc>(context),
      // ignore: missing_return
      builder: (context, state) {
        if (state is EventFetching) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is EventFetched) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int i) => EventCard(
                state.events[i],
                DeatilScreenPage(
                  state.events[i],
                ),
              ),
              childCount: state.events.length,
            ),
          );
        }
      },
    );
  }
}
