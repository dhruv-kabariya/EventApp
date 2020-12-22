import 'package:event/pages/eventList.dart';
import 'package:event/pages/historyEvents.dart';
import 'package:event/widgets/clubListView.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationBarList with ChangeNotifier{

int _selectedState = 0;


  List<Widget> _widgets = [
    EventlistView(),
    ClubListView(),
    HistoryEventListView()
  ];

  get currentPage => _widgets[_selectedState];

  changePage(int i){
    _selectedState = i;
    notifyListeners();
  }
  
  void selectPage(int i){
    changePage(i);
  }

}