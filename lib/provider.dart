import 'package:flutter/cupertino.dart';

class Homeprovider extends ChangeNotifier {
  double webindi = 0;

  void webprogress(double webindi) {
    this.webindi = webindi;
    notifyListeners();
  }

  String? websearch = "https://www.google.com/";

  void onwebsearch(String websearch) {
    this.websearch = websearch;
  }

  List allBookmarks = [];

  void addBookMarks(String bookmark) {
    allBookmarks.add(bookmark);
    notifyListeners();
  }
  void deleteBookMarks(int bookmark){
    allBookmarks.removeAt(bookmark);
    notifyListeners();
  }
}
