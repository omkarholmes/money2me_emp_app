import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

ChangeNotifierProvider<DashBoardNotifier> dashboardProvider =
    ChangeNotifierProvider<DashBoardNotifier>((ref) => DashBoardNotifier());

class DashBoardNotifier extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void changeIndex(int value) {
    if (_selectedIndex != value) {
      _selectedIndex = value;
      notifyListeners();
    }
  }
}
