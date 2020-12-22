import 'package:event/Bloc/EventBloc/eventbloc_bloc.dart';
import 'package:event/pages/EventDetailScreen.dart';
import 'package:event/widgets/EventListCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventlistView extends StatefulWidget {
  @override
  _EventlistViewState createState() => _EventlistViewState();
}

class _EventlistViewState extends State<EventlistView> {
  EventblocBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<EventblocBloc>(context)..add(FetchEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventblocBloc, EventblocState>(
      cubit: bloc,
      // ignore: missing_return
      builder: (context, state) {
        if (state is EventFetching || state is EventblocInitial) {
          return SliverFillRemaining(
            child: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
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

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
