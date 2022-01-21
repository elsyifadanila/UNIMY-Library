import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unimy_beacon_navigation/viewstate.dart';

class RootChangeNotifier with ChangeNotifier {
  ViewState _viewState = ViewState.IDLE;

  File? _imageFood;
  Map<String, bool> _isPushedNotification = {};

  void setPushedNotification(String identifier, bool pushed) {
    _isPushedNotification[identifier] = pushed;
    notifyListeners();
  }

  void setState(ViewState newState) {
    _viewState = newState;
    notifyListeners();
  }

  void setBeaconsImage(File user) {
    _imageFood = user;
    notifyListeners();
  }

  File? get getBeacons => _imageFood;
  Map<String, bool> get getPushedNotification => _isPushedNotification;
  ViewState get getViewState => _viewState;
}
