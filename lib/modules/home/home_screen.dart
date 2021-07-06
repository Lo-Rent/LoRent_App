import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lo_rent/constants.dart';
import 'package:lo_rent/modules/home/widgets/options_card_widget.dart';
import 'package:lo_rent/utilities/app_images.dart';
import 'package:lo_rent/utilities/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kAppName,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: kPrimaryColor),
        ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: kPrimaryColor),
        leading: Image(
          image: AssetImage(AppImages.NO_BG_LOGO),
        ),
        //Icon(Icons.sort, color: Colors.black),

        // Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage(AppImages.NO_BG_LOGO), fit: BoxFit.cover),
        //     borderRadius: BorderRadius.only(
        //         topRight: Radius.circular(10.0),
        //         bottomRight: Radius.circular(10.0)),
        //   ),
        // ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () => print('Notifications button pressed'),
            splashRadius: 25,
          ),
          SizedBox(width: 10.0),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // temporary logout button, just for development purpose, will be replaced by drop down menu
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, FadeInRoute(routeName: RouteNames.LOGIN));
            }, //TODO print('Account button pressed'),
            splashRadius: 25,
          ),
        ],
        backgroundColor: Colors.deepPurple[600],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: OptionsCardWidget(
                    boxMargin: EdgeInsets.fromLTRB(20.0, 30.0, 10.0, 10.0),
                    icon: Icons.add,
                    text: 'Add House Listing',
                    onPressed: () => Navigator.push(context,
                        SlideRoute(routeName: RouteNames.ADD_HOUSE_LISTING)),
                  )),
                  Expanded(
                    child: OptionsCardWidget(
                      boxMargin: EdgeInsets.fromLTRB(10.0, 30.0, 20.0, 10.0),
                      icon: Icons.house_outlined,
                      text: 'House Listings',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: OptionsCardWidget(
                    boxMargin: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 30.0),
                    icon: Icons.person_outline,
                    text: 'Manage Tenants',
                  )),
                  Expanded(
                      child: OptionsCardWidget(
                    boxMargin: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 30.0),
                    icon: Icons.history_outlined,
                    text: 'Transaction History',
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
