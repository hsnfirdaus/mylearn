class Validator {
  static const notEmpty = 'notEmpty';
  static const url = 'url';

  static String? Function(String? value) validate(
    String label,
    List<String> rules,
  ) {
    return (value) {
      if (rules.contains(Validator.notEmpty)) {
        if (value == null || value.isEmpty) {
          return "$label tidak boleh kosong!";
        }
      }

      if (value != null && value.isNotEmpty) {
        if (rules.contains(Validator.url)) {
          var regex = RegExp(
            r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
          );
          if (!regex.hasMatch(value)) {
            return "$label bukan url yang valid!";
          }
        }
      }
      return null;
    };
  }
}
