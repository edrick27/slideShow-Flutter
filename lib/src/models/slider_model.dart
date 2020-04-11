import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderModel with ChangeNotifier {
  
  double _currentPage = 0;

  

  double get currentPage => this._currentPage;

  set currentPage( double currentPage) {

    this._currentPage = currentPage;

    notifyListeners();

  }

}