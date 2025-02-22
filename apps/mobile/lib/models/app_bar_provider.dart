import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarProvider extends ChangeNotifier {
  List<Widget> _actions = [];
  List<Widget> get actions =>
      _actions.isNotEmpty ? [..._actions, const SizedBox(width: 12)] : [];

  void updateActions(List<Widget> newActions) {
    _actions = newActions;
    notifyListeners();
  }

  void resetActions() {
    _actions = [];
    notifyListeners();
  }
}

extension AppBarContextExtension on BuildContext {
  AppBarProvider get appBarProvider {
    return Provider.of<AppBarProvider>(this, listen: false);
  }
}
