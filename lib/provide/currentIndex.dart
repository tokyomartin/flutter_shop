import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier{
  int currentIndex=0;
  String name = 'currentIndexProvide';
  String value = 'currentIndexProvide';
  
  changeIndex(int newIndex){
    currentIndex=newIndex;
    notifyListeners();
  }

}