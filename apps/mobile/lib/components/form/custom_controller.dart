class CustomController<T> {
  T? value;
  void Function(T?)? _onValueChanged;

  CustomController({this.value});

  void setValue(T? newValue) {
    value = newValue;
    _onValueChanged?.call(value);
  }
}
