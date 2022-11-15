import 'package:flutter/material.dart';

import '../pages/pg_one.dart';
import '../pages/pg_two.dart';
import '../pages/pg_three.dart';


class NavbarTabSelectedModel extends ChangeNotifier {
  int _currentTab = 0;
  List <Widget> _pages = [
    One(),
    Two(),
    Three(),
  ];

  set currentTab(int tab) { this._currentTab = tab; notifyListeners();}
  int get currentTab => this._currentTab;
  get currentScreen => this._pages[this._currentTab];
}