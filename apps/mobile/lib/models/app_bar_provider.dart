import 'package:flutter/material.dart';

class AppBarProvider extends ChangeNotifier {
  Map<String, dynamic>? _taskDetail;
  void Function()? _taskDetailRefresh;
  Map<String, dynamic>? get taskDetail => _taskDetail;
  void Function()? get taskDetailRefresh => _taskDetailRefresh;

  void setCurrentTaskDetail(
    Map<String, dynamic>? newDetail,
    void Function()? newRefresh,
  ) {
    _taskDetail = newDetail;
    _taskDetailRefresh = newRefresh;
    notifyListeners();
  }
}
