import 'package:intl/intl.dart';

const String kCommonResponseDatePattern = "yyyy-MM-dd";
const String kCommonResponseDateQueryPattern = "dd-MM-yyyy";
const String kCommonResponseDateJapanPattern = "yyyy年MM月dd日";
const String kDateWithoutYearPattern = 'MM/dd';
const String kSimpleDatePattern = 'yyyy/MM/dd';
const String kSimpleDateDMY = "dd/MM/yyyy";
const String kTimeDatePattern = 'dd/MM/yyyy HH:mm:ss';
const String kEndPeriodDatePattern = "yyyy-MM-dd HH:mm";
const String kTimePaymentDatePattern = "yyMMdd_hhmmss";
const String kLineChartDatePattern = 'MM/dd';
const String kHourMinute = 'HH:mm';

class DateUtil {
  static String getCurrentDateString(String pattern) {
    return DateFormat(pattern).format(DateTime.now());
  }

  static String format(
    String pattern,
    DateTime dateTime, {
    String? errorReturn,
  }) {
    try {
      return DateFormat(pattern).format(dateTime);
    } catch (e) {
      // logger.e(e);
      if (errorReturn != null) {
        return errorReturn;
      } else {
        rethrow;
      }
    }
  }

  static DateTime parse(
    String pattern,
    String inputString, {
    DateTime? errorReturn,
  }) {
    try {
      return DateFormat(pattern).parseStrict(inputString).toLocal();
    } catch (e) {
      // logger.e(e);
      if (errorReturn != null) {
        return errorReturn;
      } else {
        rethrow;
      }
    }
  }

  //ISO-8601
  static DateTime parseV2(
    String inputString, {
    DateTime? errorReturn,
  }) {
    try {
      return DateTime.parse(inputString).toLocal();
    } catch (e) {
      if (errorReturn != null) {
        return errorReturn;
      } else {
        // logger.e(e);
        rethrow;
      }
    }
  }

  static String reformat(
    String currentPattern,
    String newPattern,
    String inputString, {
    String? errorReturn,
  }) {
    try {
      //convert string to DateTime
      final DateTime dateTime = DateFormat(currentPattern).parse(inputString);
      return DateFormat(newPattern).format(dateTime);
    } catch (e) {
      if (errorReturn != null) {
        return errorReturn;
      } else {
        // logger.e(e);
        rethrow;
      }
    }
  }

  static DateTime? commonParse(String? inputString) {
    try {
      if (inputString == null) {
        return null;
      } else {
        return DateFormat(kCommonResponseDatePattern)
            .parse(inputString)
            .toLocal();
      }
    } catch (e) {
      // logger.e(e);
      return null;
    }
  }

  static String toPattern(String pattern, String? inputString) {
    try {
      if (inputString == null) {
        return '';
      } else {
        return format(
          pattern,
          DateFormat(kCommonResponseDatePattern).parse(inputString),
        );
      }
    } catch (e) {
      // logger.e(e);
      return '';
    }
  }

  static String toPatternV2(
    String pattern,
    String inputString, {
    String? errorReturn,
  }) {
    try {
      return format(pattern, DateTime.parse(inputString));
    } catch (e) {
      // logger.e(e);
      return errorReturn ?? '';
    }
  }
}
