import 'package:flutter/material.dart';
import 'package:lo_rent/constants.dart';
import 'app_themes.dart';

class Ui {
  static BoxDecoration getBoxDecoration(
      {Color color, double radius, Border border, Gradient gradient}) {
    return BoxDecoration(
      color: color ?? kAccentColor,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(
            color: kAccentColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5)),
      ],
      border: border ?? Border.all(color: kAccentColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static InputDecoration getInputDecoration(
      {BuildContext context,
      String hintText = '',
      IconData iconData,
      Widget suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.caption,
      prefixIcon: iconData != null
          ? Row(
              children: [
                Icon(iconData, color: kHintTextColor),
                SizedBox(width: 14)
              ],
            )
          : SizedBox(),
      prefixIconConstraints: iconData != null
          ? BoxConstraints.expand(width: 38, height: 38)
          : BoxConstraints.expand(width: 0, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.all(0),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
    );
  }
}
