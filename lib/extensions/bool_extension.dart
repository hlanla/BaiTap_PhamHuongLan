extension BoolExtension on bool? {
  bool reverse() {
    if (this != null) {
      return !this!;
    }
    return false;
  }
}
