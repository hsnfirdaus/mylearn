import 'package:flutter/material.dart';
import 'package:mylearn/components/form/form_label.dart';

class InputLabel extends StatefulWidget {
  const InputLabel({
    super.key,
    required this.label,
    required this.hintText,
    this.validator,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLines;
  final TextInputType? keyboardType;
  final int? minLines;

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
    return Column(
      children: [
        FormLabel(
          label: widget.label,
          isError: _hasError,
          isFocused: _isFocused,
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
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
