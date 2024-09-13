import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


AutoDisposeChangeNotifierProvider<StepNotifier> stepProvider =
ChangeNotifierProvider.autoDispose<StepNotifier>((ref) => StepNotifier());

class StepNotifier extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void continueAction(BuildContext context) {
    _currentIndex++;
    notifyListeners();
  }

  void backAction(BuildContext context) {
    if(_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
    else{
      Navigator.pop(context);
    }
  }

}