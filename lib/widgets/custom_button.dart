import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key key,
    @required this.color,
    @required this.child,
    @required this.onPressed,
    this.padding,
    this.borderRadius,
    this.highlightedElevation,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double highlightedElevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: this.color.withOpacity(0.3),
              blurRadius: 40,
              offset: Offset(0, 15)),
          BoxShadow(
              color: this.color.withOpacity(0.2),
              blurRadius: 13,
              offset: Offset(0, 3))
        ],
      ),
      child: MaterialButton(
        elevation: 0,
        highlightElevation: highlightedElevation ?? 0,
        onPressed: this.onPressed,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        color: this.color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 15.0)),
        child: this.child,
      ),
    );
  }
}
