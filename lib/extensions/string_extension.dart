extension StringExtension on String? {
  bool get isNotNull => this != null;

  bool get isNullOrEmpty {
    return this == null || this!.trim() == '';
  }

  bool get isNotNullAndNotEmpty => !isNullOrEmpty;

  String stringEmptyIfNull() {
    return this ?? '';
  }

  String getLastName() {
    if (this != null) {
      final lastSpace = this?.lastIndexOf(' ');
      if (lastSpace == -1) {
        return this!;
      }
      final lastName = this!.substring(lastSpace!, this!.length);
      return lastName;
    }

    return '';
  }

  String getHourWorkShift() {
    if (this != null) {
      return this!.substring(0, 5);
    }
    return '';
  }
}
