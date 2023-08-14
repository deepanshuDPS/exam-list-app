import 'package:flutter/material.dart';
import 'package:exam_list/utils/colors.dart';

class AppStyles {
  static TextStyle robotoBold() {
    return const TextStyle(
      color: Colors.black,
      fontFamily: 'RobotoSlab',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle fontSize12() {
    return const TextStyle(fontSize: 12, color: Colors.blueGrey, fontWeight: FontWeight.w400);
  }

  static TextStyle description() {
    return const TextStyle(color: Colors.black, fontWeight: FontWeight.w200);
  }

  static TextStyle robotoWhiteText() {
    return const TextStyle(fontFamily: 'RobotoSlab', color: Colors.white);
  }

  static TextStyle robotoOrangeText() {
    return const TextStyle(
        fontFamily: 'RobotoSlab',
        color: appDarkBlue,
        fontWeight: FontWeight.bold,
        fontSize: 18);
  }

  static TextStyle robotoBlackText() {
    return const TextStyle(fontFamily: 'RobotoSlab', color: Colors.black);
  }

  static TextStyle blackBoldText() {
    return const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  }

  static TextStyle blackSemiBoldText() {
    return const TextStyle(color: Colors.black, fontWeight: FontWeight.w500);
  }

  static TextStyle inputTextStyle() {
    return const TextStyle(fontSize: 14, color: Colors.black);
  }

  static TextStyle inputHintStyle() {
    return const TextStyle(fontSize: 14, color: Colors.black87);
  }

  static InputDecoration inputDecoration(String hintText, IconData icon,
      {double paddingVertical = 4}) {
    var outLineBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: appRed, width: 2.0),
      borderRadius: BorderRadius.circular(30.0),
    );
    return InputDecoration(
      hintText: hintText,
      hintStyle: inputHintStyle(),
      enabledBorder: outLineBorder,
      errorBorder: outLineBorder,
      disabledBorder: outLineBorder,
      focusedBorder: outLineBorder,
      focusedErrorBorder: outLineBorder,
      contentPadding: EdgeInsets.only(
          top: paddingVertical, bottom: paddingVertical, right: 4),
      prefixIcon: Padding(
        padding: EdgeInsets.only(
            left: 20, right: 10, bottom: paddingVertical != 4 ? 40 : 0),
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }

  static InputDecoration inputDecorationWithoutIcon(String hintText,
      {double paddingVertical = 4, String? prefixText}) {
    var outLineBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: appRed, width: 2.0),
      borderRadius: BorderRadius.circular(10.0),
    );
    return InputDecoration(
      hintText: hintText,
      prefixText: prefixText,
      labelText: null,
      hintStyle: inputHintStyle(),
      enabledBorder: outLineBorder,
      errorBorder: outLineBorder,
      disabledBorder: outLineBorder,
      focusedBorder: outLineBorder,
      focusedErrorBorder: outLineBorder,
      contentPadding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
    );
  }

}
