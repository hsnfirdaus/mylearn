import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mylearn/components/bottom_sheet_container.dart';

Future<T?> showDynamicBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext context) builder,
  bool useRootNavigator = false,
  bool expand = false,
  bool isDisableContainer = false,
}) {
  return showMaterialModalBottomSheet<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    backgroundColor: Colors.transparent,
    expand: expand,
    builder: (BuildContext context) {
      if (isDisableContainer) return builder(context);

      return BottomSheetContainer(child: builder(context));
    },
  );
}
