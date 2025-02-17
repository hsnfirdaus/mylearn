import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_data.dart';
import 'package:provider/provider.dart';

extension BuildContextExtension on BuildContext {
  AppThemeData get appTheme {
    return watch<AppThemeData>();
  }
}
