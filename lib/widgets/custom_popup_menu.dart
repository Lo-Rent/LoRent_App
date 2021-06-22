import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lo_rent/constants.dart';

class PopupMenuWidget extends StatefulWidget {
  const PopupMenuWidget({
    Key key,
    @required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding,
    this.child,
    this.offset,
    this.enabled,
    this.shape,
    this.color,
    this.enableFeedback,
    this.labelText,
    this.textAlign,
    this.isFirst,
    this.isLast,
    this.icon,
  }) : super(key: key);

  final PopupMenuItemBuilder<String> itemBuilder;
  final String initialValue;
  final PopupMenuItemSelected<String> onSelected;
  final PopupMenuCanceled onCanceled;
  final String tooltip;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Offset offset;
  final bool enabled;
  final ShapeBorder shape;
  final Color color;
  final bool enableFeedback;
  final String labelText;
  final TextAlign textAlign;
  final bool isFirst;
  final bool isLast;
  final IconData icon;

  @override
  _PopupMenuWidgetState createState() => _PopupMenuWidgetState();
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Icon(widget.icon, color: kHintTextColor),
                SizedBox(width: 14.0),
                Expanded(
                  child: PopupMenuButton(
                    itemBuilder: widget.itemBuilder,
                    initialValue: widget.initialValue,
                    onSelected: widget.onSelected,
                    onCanceled: widget.onCanceled,
                    tooltip: widget.tooltip ?? 'Choose one of the options',
                    elevation: widget.elevation ?? 10,
                    padding: widget.padding ?? EdgeInsets.all(0),
                    offset: widget.offset ?? Offset(0.0, 0.0),
                    enabled: widget.enabled ?? true,
                    shape: widget.shape ??
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                    color: widget.color,
                    enableFeedback: widget.enableFeedback ?? true,
                    child: widget.child,
                  ),
                ),
              ],
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
