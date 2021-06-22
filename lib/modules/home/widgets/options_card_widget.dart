import 'package:flutter/material.dart';
import 'package:lo_rent/constants.dart';

class OptionsCardWidget extends StatelessWidget {
  const OptionsCardWidget(
      {Key key,
      this.boxMargin,
      @required this.icon,
      @required this.text,
      this.onPressed});

  final EdgeInsets boxMargin;
  final IconData icon;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: boxMargin ?? EdgeInsets.all(20.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Theme.of(context).accentColor.withOpacity(1),
                Theme.of(context).accentColor.withOpacity(0.1)
              ],
              begin: AlignmentDirectional.topStart,
              //const FractionalOffset(1, 0),
              end: AlignmentDirectional.bottomEnd,
              stops: [0.1, 0.9],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                color: kAccentColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
          border: Border.all(color: kAccentColor.withOpacity(0.05)),
        ),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      icon,
                      color: Theme.of(context).accentColor,
                      size: MediaQuery.of(context).size.width / 10,
                    )
                  ],
                )
              ],
            ),
            Text(
              text,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: kPrimaryColor),
            ),
          ],
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Icon(
        //       icon,
        //       color: Theme.of(context).accentColor,
        //       size: MediaQuery.of(context).size.width / 10,
        //     ),
        //     SizedBox(height: 15.0),
        //     Text(
        //       text,
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodyText2
        //           .copyWith(color: kPrimaryColor),
        //       textAlign: TextAlign.center,
        //     )
        //   ],
        // ),
      ),
    );
  }
}
