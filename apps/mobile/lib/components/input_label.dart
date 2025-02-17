import 'package:flutter/material.dart';
import 'package:mylearn/theme/theme_extension.dart';

class InputLabel extends StatefulWidget {
  const InputLabel({
    super.key,
    required this.label,
    required this.hintText,
    this.validator,
    this.controller,
  });

  final String label;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  State<InputLabel> createState() => _InputLabelState();
}

class _InputLabelState extends State<InputLabel> {
  final _fieldKey = GlobalKey<FormFieldState>();

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
                  _hasError
                      ? theme.error
                      : _isFocused
                      ? theme.primary
                      : theme.text,
            ),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          key: _fieldKey,
          validator: (value) {
            if (widget.validator != null) {
              final result = widget.validator!(value);
              if (result != null) {
                setState(() {
                  _hasError = true;
                });
                return result;
              }
            }
            setState(() {
              _hasError = false;
            });
            return null;
          },
          decoration: InputDecoration(hintText: widget.hintText),
          focusNode: _focusNode,
          controller: widget.controller,
        ),
      ],
    );
  }
}
