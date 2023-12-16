extension IntExtension on int? {
  bool isResponseCodeSuccess() {
    return this == 200;
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isNotNullAndPositiveNumber {
    return this != null && this! >= 0;
  }

  bool get isNullOrNegativeNumber {
    return this == null || this! < 0;
  }

  int get zeroIfNull => this ?? 0;

  String get stringFixed {
    if (this == null) {
      return "";
    } else {
      if (this! >= 0) {
        if (this! >= 10) {
          return toString();
        } else {
          return "0$this";
        }
      } else {
        final thisAbs = this!.abs();
        return "-${thisAbs.stringFixed}";
      }
    }
  }

  String get toProvinceCode {
    if (this == null) {
      return "";
    } else {
      if (this! >= 0) {
        if (this! >= 10) {
          return toString();
        } else {
          return "0$this";
        }
      } else {
        final thisAbs = this!.abs();
        return "-${thisAbs.stringFixed}";
      }
    }
  }

  String get toDistrictCode {
    if (this == null) {
      return "";
    } else {
      if (this! >= 0) {
        if (this! >= 100) {
          return toString();
        } else if (this! >= 10 && this! < 100) {
          return "0$this";
        } else {
          return "00$this";
        }
      } else {
        final thisAbs = this!.abs();
        return "-${thisAbs.stringFixed}";
      }
    }
  }
}
