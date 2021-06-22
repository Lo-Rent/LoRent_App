import 'package:flutter/material.dart';
import 'package:lo_rent/constants.dart';

class CompanyButtonWidget extends StatelessWidget {
  const CompanyButtonWidget({
    Key key,
    this.text,
    this.onPressed,
    this.onLongPressed,
  });

  final String text;
  final Function onPressed;
  final Function onLongPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      padding: EdgeInsets.only(top: 20, bottom: 14, left: 15, right: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: kAccentColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
          border: Border.all(color: kAccentColor.withOpacity(0.05))),
      child: TextButton(
        onPressed: this.onPressed,
        onLongPress: this.onLongPressed ?? this.onPressed,
        child: Row(
          children: [
            Icon(Icons.business, color: kHintTextColor),
            SizedBox(width: 15.0),
            Text(this.text, style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    );
  }
}
