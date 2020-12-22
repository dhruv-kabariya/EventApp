import 'package:event/Bloc/maincubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: BlocProvider.of<MainCubit>(context).selected,
      builder: (context, snapshot) {
        return Container(
          child: BottomAppBar(
            color: Color(0xFF343434),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.clear_all,
                      size: 30,
                    ),
                    onPressed: () {
                      BlocProvider.of<MainCubit>(context).changePage(0);
                    }),
                IconButton(
                  icon: Icon(
                    Icons.style,
                    size: 30,
                  ),
                  onPressed: () {
                    BlocProvider.of<MainCubit>(context).changePage(1);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.history,
                    size: 30,
                  ),
                  onPressed: () {
                    BlocProvider.of<MainCubit>(context).changePage(2);
                  },
                ),
              ],
            ),
            elevation: 10,
          ),
        );
      },
    );
  }
}
