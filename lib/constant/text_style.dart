import 'package:flutter/material.dart';

import 'package:jogging_app/constant/colors.dart';

class AppStyles {
  AppStyles._();

  static const kLabelTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.black,
  );
  static const labelDataTableStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );
  static const labelLoginStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const appBarTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const dataTableStyle =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400);
  static const titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const commonTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const notificationAmountTextStyle = TextStyle(
    fontSize: 8,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
  static const primaryButtonTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const deliveryDatePickTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const titleDeliveryTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const titleDeliveryContent = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );
  static const titleDeliveryContentBold = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static const hintTextStyle = TextStyle(
    fontSize: 14,
    color: AppColors.hintTextColor,
    fontWeight: FontWeight.w500,
  );

  static const dataRangeTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const discountText = TextStyle(
    fontSize: 14,
    color: Colors.red,
    fontWeight: FontWeight.w400,
  );
  static const versionStyle = TextStyle(
    fontSize: 14,
    color: AppColors.disable,
    fontWeight: FontWeight.w400,
  );

  static TextStyle caption12Semibold({
    Color color = const Color(0xFF000000),
  }) {
    return TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle caption12RegularItalic({
    Color color = const Color(0xFF000000),
  }) {
    return TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle caption12Regular({
    Color color = const Color(0xFF000000),
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return TextStyle(
      fontStyle: fontStyle,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: color,
      decoration: decoration,
      decorationColor: color,
    );
  }

  static TextStyle button01({
    Color color = const Color(0xFF000000),
  }) {
    return TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: color,
      decoration: TextDecoration.none,
    );
  }
}
