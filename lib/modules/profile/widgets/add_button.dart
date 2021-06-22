import 'package:flutter/material.dart';
import 'package:lo_rent/constants.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({Key key, this.text, this.onPressed});

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.all(15.0),
            ),
            onPressed: this.onPressed,
            child: Row(
              children: [
                Icon(Icons.add_circle_outline, color: kHintTextColor),
                SizedBox(width: 10),
                Text(
                  this.text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: kHintTextColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
