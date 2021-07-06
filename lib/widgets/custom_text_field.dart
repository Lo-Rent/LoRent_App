import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lo_rent/constants.dart';
import 'package:lo_rent/utilities/ui.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key key,
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.initialValue,
    this.hintText,
    this.iconData,
    this.labelText,
    this.obscureText,
    this.suffixIcon,
    this.isFirst,
    this.isLast,
    this.style,
    this.textAlign,
    this.maxLines,
    this.sizedBoxHeight,
    this.controller,
  }) : super(key: key);

  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final String initialValue;
  final String hintText;
  final TextAlign textAlign;
  final String labelText;
  final TextStyle style;
  final IconData iconData;
  final bool obscureText;
  final bool isFirst;
  final bool isLast;
  final Widget suffixIcon;
  final int maxLines;
  final double sizedBoxHeight;
  final TextEditingController controller;

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 20),
      margin: EdgeInsets.only(
          left: 20, right: 20, top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: buildBorderRadius,
          boxShadow: [
            BoxShadow(
                color: kAccentColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
          border: Border.all(color: kAccentColor.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.labelText ?? "",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: widget.textAlign ?? TextAlign.start,
          ),
          SizedBox(height: widget.sizedBoxHeight ?? 0),
          TextFormField(
            keyboardType: widget.keyboardType ?? TextInputType.text,
            onSaved: widget.onSaved,
            validator: widget.validator,
            initialValue: widget.initialValue,
            controller: widget.controller,
            style: widget.style ?? Theme.of(context).textTheme.bodyText2,
            obscureText: widget.obscureText ?? false,
            textAlign: widget.textAlign ?? TextAlign.start,
            maxLines: widget.maxLines ?? 1,
            decoration: Ui.getInputDecoration(
              context: context,
              hintText: widget.hintText ?? '',
              iconData: widget.iconData,
              suffixIcon: widget.suffixIcon,
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (widget.isFirst != null && widget.isFirst) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (widget.isLast != null && widget.isLast) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (widget.isFirst != null &&
        !widget.isFirst &&
        widget.isLast != null &&
        !widget.isLast) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((widget.isFirst != null && widget.isFirst)) {
      return 20;
    } else if (widget.isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((widget.isLast != null && widget.isLast)) {
      return 10;
    } else if (widget.isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}
