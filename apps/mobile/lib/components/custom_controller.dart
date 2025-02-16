class CustomController {
  Map<String, dynamic>? value;
  void Function(Map<String, dynamic>?)? _onValueChanged;

  CustomController({this.value});

  void setValue(Map<String, dynamic>? newValue) {
    value = newValue;
    _onValueChanged?.call(value);
  }
}
