import 'package:flutter/material.dart';
import 'package:flutter_full_learn/features/BkMobil/model/person_model.dart';
import 'package:flutter_full_learn/features/BkMobil/view/card_screen.dart';

import '../view/home_screen.dart';

class ButtonViewModel extends ChangeNotifier {
  bool isLoading = false;

  void _changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<CardScreen> controlButtonValue() async {
    _changeLoading();
    await Future.delayed(const Duration(seconds: 1));
    _changeLoading();

    return CardScreen();
  }
}
